Return-Path: <netdev+bounces-268584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLY+LzNGuWmK+QEAu9opvQ
	(envelope-from <netdev+bounces-268584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:16:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 223C52A9AE2
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34D5B30D16DE
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D043B95F5;
	Tue, 17 Mar 2026 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKn/nB+m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hd4L68GN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775163B7B67
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749388; cv=none; b=oU4hq/eMn3cqJl0ZXpZbJKzahQ9Je2EbRdEXi0J16a/pd4rqgJMifk1oYWKGukTLF3z9ccScHXzOKdyUvJdOejka2DxXBX/UuSTiPNXOdV/XTqNfP0Crnvas9HrBCauBEjkD7CCMLHlo7qmPn6Y6rLCok3qW9+kvL1CtLCbvgFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749388; c=relaxed/simple;
	bh=iWkKyWZAAuG0ORdfNAxtO5CUGZ+Y+pgWbF3QQdkr1AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fn2EQPPmW9zT0CF0IsCsLiwxsloudPN31jP4VRk+IGhiH5T6/GDfpKfpvZTlEmfbZOyx+6Wok6xJYRAKFoHMxTChG01qDIHWFPQ8UM5pY4oDp5ieiin1+siQqJ3BxCh0E8NRl10fJSBg01qAPfaoEmoXaMY1Wk22ynwdcxC8PLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKn/nB+m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hd4L68GN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773749386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HW8O6rPgR7FauUXL+o5Ae/r1xKJYBrSjy0JypWWimA=;
	b=RKn/nB+mgAkxC+KvWTZNxvVOAx1x11Tw/RfcTk12Q8ASRKTYVZpSYci02pVN22AvcjKLVw
	tIUoOr6c17Tyb8ue4/WY/3GeOSx4Y9mT+JZIMMldWNhOyVJ679RLNbU+CmBcO4P80Z+juV
	ahX1lIRyGiOWPi87f/Nxs7F8RrSSOIU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-h7WylZ3QPSep7IPkc6_Jwg-1; Tue, 17 Mar 2026 08:09:45 -0400
X-MC-Unique: h7WylZ3QPSep7IPkc6_Jwg-1
X-Mimecast-MFC-AGG-ID: h7WylZ3QPSep7IPkc6_Jwg_1773749384
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4852d27f473so28270775e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773749384; x=1774354184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HW8O6rPgR7FauUXL+o5Ae/r1xKJYBrSjy0JypWWimA=;
        b=Hd4L68GNXenG9J+uQYh5mgbB8rM3KhfmzE4CME1PphOR1JyR6ZlfZOoX16aA5du/r6
         dfBThKl1WLAoV4uoDnDIzw8UsRAY+enbTOHmX69ynrsTQTnuMJ6QhzyChQZrj81LGxJA
         DukDHFu/mNglwnFQ/8inaj1GXSb56B9Y94LhbF5S4UjiDF2zgS6uqoRaNRsvL332qCh5
         FY8fGHu/ZUVmsfEQB2l6qGLKD/8J0DxFmkbREXeR58LFnE6solCGH7QhZWYusxNQCYy4
         cQpBdO5PFle0mysRqVM8moC7xAzB4doLzG0TU2gBi6EKWmDS/24Zf5DkCNJtitSGk/jr
         +iJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773749384; x=1774354184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HW8O6rPgR7FauUXL+o5Ae/r1xKJYBrSjy0JypWWimA=;
        b=bDRv0quSlTfpO8uaXIOKAWWYhSeABgKfL+LJnPlX7MxCyp4fRNGsq8KiFImASqkKgp
         RdB4OQ56LuEi4S+NtkHPwAIlPcB7Y5S2X6SLrIr59nw+3DPHexfRnNj5x07fpTVL8VV6
         C837u4toHNQYOAhuEWqAfUdZNQDtqN0t0V11n26h7toP6ArwTm0U8fSUa+oj/MfQNSpQ
         7KvT9wS6M9bvIhPMw5lJgbn6jT70Ufy0Zj6Y18d15XsKQWHW09bfpJr43O2zyzB/T7Gg
         ajyUJ6vxCPwW0xZo0ZxHc2eerFTtGQ1R9Ff5E1xIuLoQVf/WpacsHlyMOOiEaVdwIKih
         t6VA==
X-Forwarded-Encrypted: i=1; AJvYcCXnbkf8P+QaZw30haJn8LdndFpduijepFGGHQGc6eNd5kFQX41gn1hdxB1soEC6iNTI79G2okg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWdTotBzz/fB0wIgvtDkyXHIdbmjEUlb2UjE8NBzXRXBauOZGo
	n0wprEgmgsPDshqX5ikOmjl0Mo7WKTxNclpWf8bKcWOP51KxV2ZldWrYWnPLuKm1DYUNdr87mbY
	zjJEXBkIKNWuSzxPMQr0pelyQckKeJKAYWs80xfjEYs2XUUw4Z3C04nTimA==
X-Gm-Gg: ATEYQzxoMylI2IJZ41i26h8eY4Pr2AugCfxDkAiSN87797YDYnl07nl1wzeaKGpz2yG
	srL4Ts+Bgrd00HEbd/Cc/UDUjEUA/PqsZGA1+d8AaC6Vu3SOZYCt2iAF7aP+tchLJe2V5SFMnls
	Y2vMoqeLiYVBxYFrWsu/QQ6d7G4RPmuuofd1YEf8opurvAmxxPmytAwvox48th1kYl4jKGNQEVF
	Nu/I4KZ3NH2ukwXDdZkTH54qCgq6vxoPQDNY8O1MGGcdniSrL93QSr3qB4T6MANrPauF23KwG6j
	oIDeeOMDDTP14IMjIVrlQwWkL36aw4DvrWM66D7LtDoSbmU6JGf39zPGCjDc2n1W9aRKF5R+N8Y
	0dvjVKV3tbPr5p/3k7UTnCKxTUrNneIVCGAouGdDa7ESjwoOAyITyR14=
X-Received: by 2002:a05:600c:4592:b0:485:3dfc:57a with SMTP id 5b1f17b1804b1-4855671044fmr284696895e9.32.1773749384146;
        Tue, 17 Mar 2026 05:09:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4592:b0:485:3dfc:57a with SMTP id 5b1f17b1804b1-4855671044fmr284696185e9.32.1773749383627;
        Tue, 17 Mar 2026 05:09:43 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48634a7ac93sm41144035e9.2.2026.03.17.05.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 05:09:43 -0700 (PDT)
Message-ID: <27b77086-4f08-4d97-bc7a-2b5a4754a5af@redhat.com>
Date: Tue, 17 Mar 2026 13:09:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] amd-xgbe: synchronize KR training with device
 operations
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Thomas.Lendacky@amd.com,
 maxime.chevallier@bootlin.com
References: <20260313134210.3824872-1-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260313134210.3824872-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268584-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 223C52A9AE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 2:42 PM, Raju Rangoju wrote:
> @@ -2115,7 +2160,9 @@ static void xgbe_phy_perform_ratechange(struct xgbe_prv_data *pdata,
>  	XP_SET_BITS(s0, XP_DRIVER_SCRATCH_0, COMMAND, cmd);
>  	XP_SET_BITS(s0, XP_DRIVER_SCRATCH_0, SUB_COMMAND, sub_cmd);
>  
> -	/* Issue the command */
> +	/* Acquire mailbox lock for firmware command */
> +	guard(mutex)(&pdata->mailbox_lock);

Also note that Documentation/process/maintainer-netdev.rst states:


Use of ``guard()`` is discouraged within any function longer than 20 lines,
``scoped_guard()`` is considered more readable. Using normal lock/unlock is
still (weakly) preferred.

/P


