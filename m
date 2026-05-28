Return-Path: <netdev+bounces-292749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAv8IHVqGGrcjggAu9opvQ
	(envelope-from <netdev+bounces-292749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:16:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 602B65F4DC7
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67E5831AB02B
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62E33F9293;
	Thu, 28 May 2026 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMwGXCso";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dz1exjXH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A9F3FB060
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983551; cv=none; b=Ln+t8WUNL2221SmOWDER21GJgqnY1Tt1a/osSqTLBXCNrOdqC+CP/dw5ic8/bnNkjwHlW9183j8QmeUoSIK7c6G9vC9lPIiLtRe+bEBUDjP1TTDNSEFbZ9FtOb9cLR/sKFPJ4RVIoXAi+//aT55JeQ5xGOqAcyjJGoIjvVUKHX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983551; c=relaxed/simple;
	bh=NlzCQf1zx7qjA+KDWerMH4TMI8AuK36jb8QhvRl+C+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqRH8w2xm6+6iAQ1o0ouGJUANfm/Pit1afufNRkbwcXKQ2odHlKj7x7W1ebAEpk7x8ZM9CMFn9HXMW3UIY/o2RRc8T/M+OpNUCN6R6SKL3CZ1ZnZ81jnDVmSWFFxh9oe80q5HE+w1jfyDlVqO42un4yGGT0U7v1umyZoftsQhwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMwGXCso; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dz1exjXH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779983548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gKX6Ymx1leJt5qAO9KB4MjFbf+Uq9JmkuK+av9nrCKM=;
	b=ZMwGXCsoi4Ns8/oexenj+y3EUUXDzEnYuI6Vo6W6SHrX4Ygg4ZKVxaTQd81SLhs0GgRuTU
	p5bHrXiT0DlwNQpk3M+Rr5WCCGCxz5TjQSk1/H/Wda9yZYPj7UviVdlCrZ0tchhjaKqlm0
	OZ7AVDotS1x9ApzQNu89vhtbvQ0Iflw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-pmvq53TJOZmD7aCANp-Wtg-1; Thu, 28 May 2026 11:52:27 -0400
X-MC-Unique: pmvq53TJOZmD7aCANp-Wtg-1
X-Mimecast-MFC-AGG-ID: pmvq53TJOZmD7aCANp-Wtg_1779983546
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d789cebcfso8665088f8f.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779983546; x=1780588346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKX6Ymx1leJt5qAO9KB4MjFbf+Uq9JmkuK+av9nrCKM=;
        b=Dz1exjXHif217fR/15lRJlDGnl0D74PnLO8WCfPhKkBKMQ/f5H5e6Gz0GHoduDP8nl
         5KyApVKTugNrdhT1xeV4uhRBCP9XOBOcsN0074e0xLewpSUnHmUtFCCG/QPtLpHlCIpV
         kyNpG+r4TQItGfoC177TD7nI6dB1WoDZuzlDLGz9DWmpCHMl5aHq8n4Kjk97ld+UhMD0
         m4erqf9zS10wXwEmhmzeOmognwrjv1ZOXuMgcBSrre2kL2c0dOrYKxSzzX3opF25AGju
         QvQyXFvJ9/fqVkuYfOmDPv5gLI8RBKsND5CdIot3Z8omxQN+MecSiV2cSP/qKQA0Tjx2
         x/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779983546; x=1780588346;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKX6Ymx1leJt5qAO9KB4MjFbf+Uq9JmkuK+av9nrCKM=;
        b=dGZzqwPABE+SlUetnpbzkjNW2p6ug/xooudLff8ZC+i/IfgbWaa+tSZ74uP2mVIXrz
         D9JmFhka1S8pK+aPpfHdReVvT+HT0QrCi89UDQHl/IAgcQN5AGfo9jxsLLf1VuWanH1M
         CXyYmYBJtzOoafZLp2Wv21EsLIjd/pSBFMJ3FJ7Xx68LMyTdi4wwRnZANHxbUqQolw1o
         ElD43D6O9oG1h6oExc9dSsBn//bhBhynKdb70pK3nR7W40JGJANd1/AYgXeCmof2XPrm
         94NXD2g03naPCIJNYImK2GPwCobYzAP+ckqLnF2JAOQWSZXN01FusBn9aAmUu7QsctFE
         LL2g==
X-Forwarded-Encrypted: i=1; AFNElJ/xYUJXuV/qR8EQcodg6nBMk78ipB/CwT/9qY57lN2SJ8qoZ6Coqqh2gOtaqCu7uydtXzcGJgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6yl2XUQXMHnGVFwYPR7N38rWFh8IEE24yckFlNfT6556xNXF
	jiXrye1BXzLxSP8poe/yQNam+j+Qz+ezbnhPWz+LAbaONGfbbRDSP+oRfuVlePeAh3/OvYIvrQc
	vRPtAfv3yYyRdgBpGAEmHvWZwvDNhhVPbcmmEZyTxe+zyCkUvckvRXcFHLA==
X-Gm-Gg: Acq92OFwkKGygXksajt6TQ4xUZXHSDzbaMFfVL2axSpOaIV8JE60sovx6FnTPJ8TMcZ
	OrxPECmb3BxQ/0iCGY5OtLkmpeQtaCRD2rM+XiXbh2L/V2DIfLWaHVbg69BnBPNw3Pe363f2jrF
	LJmS2wqlajyuusdr/oi1maWaKlOYSXELsG5K2XFar6VoROxoI6ENIY+lsbfu0/aapXMBLauE3sf
	iSkPaSm7cacgR9VXrzovESMc/vXVpjbAVILYoRgOHWFsGPQpeZTGQaIcGtM0Pehz1iyprdGXTMh
	vRbP3WzVrgjP8fs2CFPl8YKiUiHLBbEQKBV8neHzjLA7na1xzNAMImCEYpvaLD3liwLXokB9hY0
	TPZFGmhCps8e3lZOkntIx7E9YXa0n7k9wiywHZBNJY8auxniWCC9JOrh651MY9FHvBQ==
X-Received: by 2002:a05:600c:4f14:b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-490947a780cmr36959865e9.8.1779983546049;
        Thu, 28 May 2026 08:52:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4f14:b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-490947a780cmr36959385e9.8.1779983545558;
        Thu, 28 May 2026 08:52:25 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092a82ea2sm85074295e9.9.2026.05.28.08.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 08:52:25 -0700 (PDT)
Message-ID: <46c6541e-9cd3-43f6-94d5-baac7b3fe7ad@redhat.com>
Date: Thu, 28 May 2026 17:52:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth 2026-05-28
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20260528131839.462344-1-luiz.dentz@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260528131839.462344-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org];
	TAGGED_FROM(0.00)[bounces-292749-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 602B65F4DC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 3:18 PM, Luiz Augusto von Dentz wrote:
> The following changes since commit ab1513597c6cf17cd1ad2a21e3b045421b48e022:
> 
>   Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del() (2026-05-20 16:35:47 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-28
> 
> for you to fetch changes up to cdf88b35e06f1b385f7f6228060ae541d44fbb72:
> 
>   Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2026-05-28 08:52:21 -0400)
> 
> ----------------------------------------------------------------
> bluetooth pull request for net:
> 
>  - hci_core: Rework hci_dev_do_reset() to use hci_sync functions
>  - hci_conn: Fix memory leak in hci_le_big_terminate()
>  - hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close
>  - hci_sync: Reset device counters in hci_dev_close_sync()
>  - hci_sync: fix UAF in hci_le_create_cis_sync
>  - L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
>  - L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn
>  - L2CAP: use chan timer to close channels in cleanup_listen()
>  - L2CAP: clear chan->ident on ECRED reconfiguration success
>  - ISO: fix UAF in iso_recv_frame
>  - ISO: serialize iso_sock_clear_timer with socket lock
>  - HIDP: fix missing length checks in hidp_input_report()
>  - 6lowpan: check skb_clone() return value in send_mcast_pkt()
>  - btusb: Allow firmware re-download when version matches
>  - hci_qca: Use 100 ms SSR delay for rampatch and NVM loading

I'm sorry, it did not fit today's net PR; I started cooking it quite a
bit earlier than this one, and I looked back at the ML only after
completion.

/P


