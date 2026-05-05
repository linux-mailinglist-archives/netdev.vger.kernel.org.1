Return-Path: <netdev+bounces-284370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLFPFC/m+Wl1FAMAu9opvQ
	(envelope-from <netdev+bounces-284370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:44:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEF84CDCDF
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3DFD3018D7C
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 12:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B2B3ECBCF;
	Tue,  5 May 2026 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CN/Y4Wpc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJT+BKyL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71780145355
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984825; cv=none; b=nHrDkfMtUVFH4iiGuMbI+trkPqckO0EJPTgXWxlxKgEyUNweye6g5NrnQy1bGst6+f98lPY6xD0F4FybOjBfYMe6FfeezcPY34k0Lfbi2dKemDXpJnLr3MtCcJBAQ+Jl3ohErJatjUiX2kWRwwfWIuZdkr7sxkzghJd1xiKlELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984825; c=relaxed/simple;
	bh=6YDv+1c4JwmzmFMY8xtwrnHGbCcyzUsn+VLKszJJeyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcSTJSauS9ni5PUfJH3sEVhKh/JCJlQ4adnxu4Tf1hbLvLbEKU3UA1VVY6ntO5Pp6VKCPWBC1aLdtATbozJ/dI0OWa8bz1nbdE0LpejdaFM/9/Hbf0FEtQMM9bno/IU5YSv1/452syeJSA4prMCvnmY+NwCmDOoZe3phDQ2RkM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CN/Y4Wpc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJT+BKyL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777984823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=As21FItgiv+bRKEEUeeucZuFK1kYBcoDBlx18YJO6wM=;
	b=CN/Y4WpcGJqjyVWFpwPQP4hCUdu+WbTBD9czMZ9wpApe5nO4SyBg8Sw0rMsvNQd1x5z8kv
	WMXuRthbezj59DjgjbHIbXBTC8iczc0IprbPORBtorLRmDMdLcXCjhWlNsFjtMaK1lsezB
	Pk0s0wzjTHZGrcdYWMfcjwOZsc2ChOs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-bHpMUclYO4S-PBcl9DkN0Q-1; Tue, 05 May 2026 08:40:22 -0400
X-MC-Unique: bHpMUclYO4S-PBcl9DkN0Q-1
X-Mimecast-MFC-AGG-ID: bHpMUclYO4S-PBcl9DkN0Q_1777984821
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48d121738feso13128545e9.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777984821; x=1778589621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=As21FItgiv+bRKEEUeeucZuFK1kYBcoDBlx18YJO6wM=;
        b=MJT+BKyLq5H2ArXs4+r3+AYSCpNtD+KeB7AOZ/OwTnHnWrzmac0aMezNHUF3Oavdud
         AWpKkvgdxy3rlmi4qrPzyEelx6421WzBFISmxyK4Ph/IDOG3sKADvO9fO2fOpkrtxmQc
         nU9As0DxAempWC397q5MzsNbL8AYI8Xhfa9IKfqfcFmKTsCSy98e0FlOi84ODIM993y6
         7/Y/xTA6XW6LHARcdXRjO5oKPK6GJFISF0SWYuK/7rQKBtQZHF2ZYY5157QwOozyqp43
         QtKtJa5e5yYwP8L3kYnY3PiEbYmFwo1AvmcHcUvZssI5XOPnl2VYtRwyJpcpOnZpbWSZ
         syjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777984821; x=1778589621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=As21FItgiv+bRKEEUeeucZuFK1kYBcoDBlx18YJO6wM=;
        b=BgFhVilgbbiWbAvIIvbRM42s+shCfLDoIALws79Xpk+Pwu7u8oj0qfOt/GwlZkPinF
         ecNu973ICln6MqfQc9iMmZ4bCNxicpJ7UcLo/6ZRxb/VUuOQj+/yVzL27eK+4yfZmLQh
         tIvly3rj2lNoPpFX39fd8HG3JTD7So6E5ZsNUyHXwVmOMlxfsSyzANJW+AdB8XZAiZA8
         2nKwC62Nhd9cdJt+1lLYUjHecVd76bjs2+3j3Esdkwz89gPnqDi3mZCWsy0HUyeX+hxT
         VEOQmdA4Iud9yIGWUhFk8qLH79TAiTnPK3VhssjFod/L6/tYb2/g6Ch6EkQprbnJxPZq
         DXmQ==
X-Gm-Message-State: AOJu0YwcGdUZEi32Zbb/Hs/8ypNtYbGXJP4EQhEpa48v5pn+lBqXcDrh
	WgQ8gMSj3WccjkNaJiM0Q1x1TdcRNWM37xxKgtHLwcw0xfXJMfi4g53TCclD4w3cxqqeT1hG0cD
	HoSI6YM2sCmeJ0eDNQd3As2d+SsqiG6sk5elz+i3eJ26Q5oT/LGacTTrNUg==
X-Gm-Gg: AeBDiev0xfGdkqLlQheAAwJeTi7c6cTf2Amzwjlnek1csZs1S1SnZdhfrTwQS8vEK3G
	b37N1zq001CUyHreTpuIXMJK9vLJqV2CBQqe7EvQikhVgf7YdBLdgyUzrgLTi+0bjHM8/mAid00
	hFHTjoLoZVCkO0rqGK/wn2LE2emW8kk18GuksdgjLzOMgJ98nVE65IUbg1NvvjIkcLyD8Y2RsxM
	f7JYpWSBxMPX1EVYB8xI0WCm5ehX/Ps5JRfu8o/83q/J2+xAGWvnYVLWFfmP0Tb4HftHQYGfX1w
	TL8LMzef3zgvRkBiqUnRimuOoxPpoafiam6+6XAjjfKuyBDLtixjon4wy1pmdEqNYF2OXkzbCnj
	S/+H1/dqfus8hhmj8mELJotGAGRxnanWb0RFJ09SEHG15wL1KUgPTEMeGDlp9YbMTTII=
X-Received: by 2002:a05:600c:8217:b0:486:ff92:63e5 with SMTP id 5b1f17b1804b1-48a9852e568mr255574105e9.6.1777984820947;
        Tue, 05 May 2026 05:40:20 -0700 (PDT)
X-Received: by 2002:a05:600c:8217:b0:486:ff92:63e5 with SMTP id 5b1f17b1804b1-48a9852e568mr255573205e9.6.1777984820482;
        Tue, 05 May 2026 05:40:20 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebb2f32sm353251655e9.13.2026.05.05.05.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 05:40:19 -0700 (PDT)
Message-ID: <7d657e09-1037-4f0d-b0f6-70228a4acccd@redhat.com>
Date: Tue, 5 May 2026 14:40:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: eth: fbnic: Add pma read and write
 access
To: mike.marciniszyn@gmail.com, Alexander Duyck <alexanderduyck@fb.com>,
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Jacob Keller <jacob.e.keller@intel.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Lee Trager <lee@trager.us>,
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430150802.3521-1-mike.marciniszyn@gmail.com>
 <20260430150802.3521-4-mike.marciniszyn@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260430150802.3521-4-mike.marciniszyn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ECEF84CDCDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284370-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,armlinux.org.uk,intel.com,trager.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fb.com:email]

On 4/30/26 5:08 PM, mike.marciniszyn@gmail.com wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> 
> Document the MDIO interface topology with an ASCII diagram
> showing the MAC, PCS (MMD 3), FEC, Separated PMA (MMD 8), and PMD
> (MMD 1) blocks and their interconnects. The diagram illustrates how
> 4 lanes connect the MAC through PCS, FEC, and PMA, then narrow to
> 2 lanes at the PMD.
> 
> The c45 read and write routines are enhanced to support
> read and write of the separated PMA for the fbnic.
> 
> Co-developed-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
> ---
> v2:
>   - no changes
> v1: https://lore.kernel.org/all/20260428172810.175077-5-mike.marciniszyn@gmail.com/
> 
>  drivers/net/ethernet/meta/fbnic/fbnic_csr.h  |  1 +
>  drivers/net/ethernet/meta/fbnic/fbnic_mdio.c | 71 ++++++++++++++++++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> index 81794bd326e1..64b958df7774 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> @@ -805,6 +805,7 @@ enum {
>  #define FBNIC_CSR_END_PCS		0x10668 /* CSR section delimiter */
> 
>  #define FBNIC_CSR_START_RSFEC		0x10800 /* CSR section delimiter */
> +#define FBNIC_RSFEC_CONTROL(n)	(0x10800 + 8 * (n))	/* 0x42000 + 32*n */

Sashiko says:

---
With the introduction of the RSFEC memory space at 0x10800, does the bounds
check in fbnic_mdio_write_pcs() need to be updated to prevent clobbering
these new registers?
While not introduced by this patch, fbnic_mdio_write_pcs() currently
contains:
    /* Allow access to both halves of PCS for 50R2 config */
    if (addr > 2)
        return;
When addr is 2, FBNIC_PCS_PAGE(2) evaluates to 0x10000 + 0x400 * 2, which
is 0x10800.
Since this overlaps with FBNIC_CSR_START_RSFEC, an MDIO write to MMD 3
(PCS) at address 2 could silently overwrite the newly managed RSFEC
control registers.
The read function fbnic_mdio_read_pcs() correctly uses if (addr >= 2) to
prevent this. Should the write function be updated to match?
---

Does not look blocking to me, but a follow-up could be needed.

/P


