Return-Path: <netdev+bounces-280025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIfwAzsn52nV4QEAu9opvQ
	(envelope-from <netdev+bounces-280025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:28:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 658F9437911
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B165B3018295
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B6538736A;
	Tue, 21 Apr 2026 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZEVvcrW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVhqt+Lw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E5534CFC2
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756517; cv=pass; b=hfYj1QJYvsOSpBeM6Zp4Az/9EslIj1l98h7o0N6iAT0QeVDt1BWLqkekBH7lMA3OIvY3ckUlmcMDPMLTOuy7u0XqEa2Rhi0DdWb49qPPCg30b0kHPz1uZA+/55j0lrmO2cisC7bL+IaydBZNwhwHYmzCHQMxq8ngRkLueoRNc3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756517; c=relaxed/simple;
	bh=wwmZXFfudo6vtD8Qyo2Fqwkv5D5eNldWMhPAPtQB018=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcu2vmbuF5tqRY8F2tZkNN97jeeXMQGdMErsLDP/Kl37gRBPqXeZGe0d6jT577WDmt80M0VVFCD/eTqkbITIz5exxHAs+oszrEKaVGj3gQ5BNhwn7u3FyBt96PMM+VTFI40WI+y3OGnqn1TFvbvEoVXMy8RKyhKiAQM1NUfCvuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZEVvcrW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVhqt+Lw; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776756515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1NxogECpqiNsO+aGXAiC6wMG+jNg2PWSddJ9oGiQTNE=;
	b=iZEVvcrWvfy54CNb3lCrxD6hQa/7k/kJMuZD4OJqyfMnl3Wm5yOu/DibVHSoe78qSCw54B
	owNWLa8X1Whru0/AY5vXIAAB/nPOSCvb3bpgEumcMBpEtI3FlyKZPOS79U8dTmhqPufRpc
	3uhW1H/3BHttGEZLWxtZCdILUOcrANY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-RN2wqS-lO1qXqS-bgr2h6g-1; Tue, 21 Apr 2026 03:28:32 -0400
X-MC-Unique: RN2wqS-lO1qXqS-bgr2h6g-1
X-Mimecast-MFC-AGG-ID: RN2wqS-lO1qXqS-bgr2h6g_1776756511
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35fbc53b64bso4618455a91.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 00:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776756511; cv=none;
        d=google.com; s=arc-20240605;
        b=EwOzdt94IB1bK9J3K+tJm6NqdFa9YMQhY785ddUtHP90iXua7zVEZneRBKaOSFo3xh
         mykGNR+7N8EKq0HOf2pc3vGiSrFzf5yFADdo1MXhQjcXec+anvpSvQ9oivUv0i0W+4eG
         ntHuuqCPj3V+In3TRzzh6IK/nsLYqZJ37Mzcu0n6NHoKBMalIdfx9BYRtt1vnu+QxpbL
         DWz6ro0vatEyPUe/+ZmdjgstWwQB4zdIGWekfiRkZWRo5ZeWh7w9FhREuEKP7ome1JVT
         sIyuW3GHm6jjZp9JN3VtuZpztkFuXae+8SVNYj5kaS0JQwVX+p54Ln5uH28NDMnSjeet
         csyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1NxogECpqiNsO+aGXAiC6wMG+jNg2PWSddJ9oGiQTNE=;
        fh=iXG10/OU/zjj9SvIMnUnmsBDI/CpjBifuOZeqliaU5o=;
        b=Lasw/8YlFUDbORCD7H6f3AeHPddo0vIWSEk8nrL8i+g+xLnxEVO8Ue/F2/mjHu6Vng
         WczzKqw5t5zgCfEIk34dcjByGvBY6V1rCBntMFRwR4w66ADcUAVCXuaoLscT2tmz75Oa
         LyDiCcxFG95YqEXnX6+DCwsr4MV1TtvUvExkssSFkeR3EZ2u/RBol5Sp+0OQ423XNvSP
         QDXwnV9lOEFt2aoXW+eILU1KUpbXta2x2y2HLtW0zi7VH8ose3I7XEp28vLn8XzSPmIk
         wqcGcYtvb2STA+uDoHsujELBzApFnSnUtm76+Z9YYFHRbohMABhR/Cci1T7TK0ck6EYv
         eGcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776756511; x=1777361311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1NxogECpqiNsO+aGXAiC6wMG+jNg2PWSddJ9oGiQTNE=;
        b=UVhqt+Lw4Baw/TvCDHMwBfj+G//AE5fZSaVch46WkQSV0EJ2vD14K+JTJrykSxPJQ2
         E3fsjwrXJj6s01fnM/PNPCM0SdQ+mw3x4OQbr76RZl30XbA/OPFShjFr6r2vCSm7glW8
         rCF+6sLQbURLm4mP7nv56qyzY8WbRY1zjjceMc2L1ZWrc7IdnRLiMAuT1Tb9PjvzlXOj
         JzdIfAxMcXgJjoGXjKXRfY9Mg4uYN1vZ+UV2WrZQ7Q7D/2svRUwyTXXYLZUBZm0zB8HI
         F1V8i6s9F74GroTnyEeVbT9RsL3ZlM8N90uMX0d04FBcyK8FX5UNB0eUwTShubuzQyVC
         QVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776756511; x=1777361311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NxogECpqiNsO+aGXAiC6wMG+jNg2PWSddJ9oGiQTNE=;
        b=UQyKrXdah9UR3V0vZ68EOhzJMZarc5h6FOZ7EHlL7xK4vlWZ3MPhbfuvKZGKONYHqY
         A001N8MizpCoHG5HUppQ16JdyG43uFa3cv+m0De6MM2qC6GEHsMQlJ80LGzBrOAiPYrK
         kHqCCnDOhgdYcvPzHvr92g70MlHDSq01nMKuMJu41U41Iv2Cs65KlTvpglODuMLeTsgf
         Wfg4DlRUO/irx4u1LP1iEeSMUGSktSLph49WzAKXJNsQ9poAI61LHtjX2msiJInMA6XO
         AnyRhBYb6UQSuziab41q67WKzXY/GtPRTF0cfjfceSiBviq3qkndOzLo5Bv33HUgkYt4
         2ChA==
X-Forwarded-Encrypted: i=1; AFNElJ/INHV64+4xt9cUoCUO/7Uih/J43hKeRD38HjoXVNqgObdr7nn4ypYkpZUGkDcVSSNqjPLcODM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJc4JrFtd82VrSZgU3V1tJfVIfgDgqEA+k+xnP5c7dRO+UcH0w
	9R4lIxgcmwt5scOr80h1WANRPZ9LLKE+C7knx31aOr85+fZHiYzprz89oN5D0VjVgaOFQZL//7p
	SLW5grapErIEOEsy/4Rhp3T4HK36/SC4exP+zfD4da3yCdcfCDxSEAnYmCmNdYf2+4DA7YIokE6
	aGGTy+AuNBoViTgP/zyX9LhQXj4Cmz+Jbi
X-Gm-Gg: AeBDieumbwpooKKMku1vKV+fll99Wo1LhxV9784uNZGVtuNnlwF7nJekTepDMginIKl
	oa0ttye/7jf0NJYei8L6cMIZO8CySaKrXwvzmFe9KVFBUvdKAjbkJZolT51KHqfSF2BLPJ6p/OU
	ZYbOjophnUTOmGPjGc7TgCXo+QZwfLWbp87+2RKxdwrQIhW6uRp4p12YKTW4IU9n78kBHc+8+7q
	xoxzdgfU2Odygo=
X-Received: by 2002:a17:90b:4d0e:b0:35e:5ae3:298a with SMTP id 98e67ed59e1d1-36140462ad9mr17177830a91.18.1776756511181;
        Tue, 21 Apr 2026 00:28:31 -0700 (PDT)
X-Received: by 2002:a17:90b:4d0e:b0:35e:5ae3:298a with SMTP id
 98e67ed59e1d1-36140462ad9mr17177809a91.18.1776756510684; Tue, 21 Apr 2026
 00:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416191433.840637-1-decui@microsoft.com> <177672238581.1802062.15838493180057695674.git-patchwork-notify@kernel.org>
 <SA1PR21MB69214CABCA0DCD597040F849BF2C2@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB69214CABCA0DCD597040F849BF2C2@SA1PR21MB6921.namprd21.prod.outlook.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 21 Apr 2026 09:28:19 +0200
X-Gm-Features: AQROBzDJwpjJV5oYDv9Ov-Jk-nnVA6bAoKM78g-QgMrimqa9KxhcXRiVCwSyCjw
Message-ID: <CAGxU2F6DVcLDLg3dT5DsDmsaOuhOcD+4VSG5dqXcFRwsN1NZ+A@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v2] hv_sock: Report EOF instead of -EIO
 for FIN
To: Dexuan Cui <DECUI@microsoft.com>
Cc: "patchwork-bot+netdevbpf@kernel.org" <patchwork-bot+netdevbpf@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
	"niuxuewei.nxw@antgroup.com" <niuxuewei.nxw@antgroup.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Ben Hillis <Ben.Hillis@microsoft.com>, 
	"levymitchell0@gmail.com" <levymitchell0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,davemloft.net,google.com,redhat.com,antgroup.com,vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-280025-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,netdevbpf];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 658F9437911
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 at 05:13, Dexuan Cui <DECUI@microsoft.com> wrote:
>
> > From: patchwork-bot+netdevbpf@kernel.org <patchwork-
> > bot+netdevbpf@kernel.org>
> > Sent: Monday, April 20, 2026 3:00 PM
> > > [...]
> >
> > Here is the summary with links:
> >   - [net,v2] hv_sock: Report EOF instead of -EIO for FIN
> >  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=f63152958994
>
> Hi Jakub, Stefano,
> I'm sorry -- I just posted v3
>     https://lore.kernel.org/linux-hyperv/20260421025950.1099495-1-decui@microsoft.com/T/#u
> and then I realized that the v2 had been merged into the main branch :-(
>
> Should I post a new delta patch(with a Fixes tag against the v2) based on the main branch?

Ehm, I'm not sure about the process but if it's merged in net tree,
maybe we need a follow up patch.

Anyway, let's wait for Jakub's or other net maintainers' suggestions.

Thanks,
Stefano


