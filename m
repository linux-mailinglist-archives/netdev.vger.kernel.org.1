Return-Path: <netdev+bounces-261619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBgJF3jLoGmlmgQAu9opvQ
	(envelope-from <netdev+bounces-261619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 23:38:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C832A1B076A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 23:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCA5C3023E2D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D1C393DD6;
	Thu, 26 Feb 2026 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lycF4A4v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A753A7833
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772145524; cv=pass; b=CPbxlj6I/M1wu6vDEUsqMsi7xCccP3vIv7R0QNsKW4rlRv9otwwLt8CPrWfODG3CupjkT9RJevT1oJ2LuoAlHByw2P0jQ/u+2wy2+EuBTJwndaaeLILykBZ//c7Bzy0VL7yKxv2SBZ68+4Sb4llr2aoIdL+w5rxVucyIsDZy+ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772145524; c=relaxed/simple;
	bh=+J/vTIMml5Zf8d96mjFzvZXL00rTAPt1cr8sN/8kfz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvrChMvqbQisMgcp8Esi28PtObHpFytpTQg7lU56+UUtb0ReS0tFvErRvs6D0EqqQKoVnoRVOl+XGBIfJSddgeiA+pdMeZFci/WGk5uoGiqn+yZ9vhtq24K4oRFqJxa9R+aAMen9ENBexf9JSyyOqyoJ6t/8dSVH4vJCEll9Rqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lycF4A4v; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1271195d2a7so2438043c88.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 14:38:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772145522; cv=none;
        d=google.com; s=arc-20240605;
        b=RQrz/D/XYghU06CnjoSD1G0kdPeGf8mY5KQF7055A/D5y2YOi3gwJvMNWIrpNo+Tvs
         9DHPUxHkpd8xHJ66ya1DNjQNZzTeToFXrcs1BnYpV3GSi2Ja8ofYAKFD02UEMwemmneP
         3WZSmLOvaDMIvfiVoKGpD2NsLTRwHB0b6yJkU+ijIUZCPuulhRybvWApvOq/S/w2wLom
         ablTCjjtHpu/gCpqWWdMdi2jNhsmpUBtYwZPTtomc1FozT83qCAmCGK+XG5VE7LpcUWe
         GHq2uefVoR3exBk1+ksKtSRN3rCIb3hiKobUY6dx6hjwt/gJCcmmjV9reeWVotVSIdDf
         8ZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2YoyBcTKf/eowDUgfYTU2q5ldvWbEXr4DJ0qkj2nIEM=;
        fh=ybo84GQ88zNTdXHnKYTjx5AZGe2JDauEg0igzPx96Ik=;
        b=leTPS7vDuBZx52bknZL15osbR7XbwhF52CBFw4+J0Umih7b+hzBTEG5ioHUqWmcWo0
         OjQFdUsvE/G87j7RNhdrBzdAx3gtZC01c0pErsaO90XNT7NQ01LI2dMFjRhEIDOGTDF1
         opMZABxlruX0t80IHyOgX9W/R4iQupaBkfZ1FdnmRs5JTIAv5DOQl8MO20i54qUJ7K7x
         xLufu0JN3MF1HC4d08POq86/5Yqsx/+AqkmeHfRsL1+3iiugOpNOpLR7YB0041NdKM3V
         zmivB0O/Iz9/J4pRL6MKiMWfal6r2CwS+1k0WQtdse1wpXRZRCWg9kpxk3/eQLLUtf4u
         h9zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772145522; x=1772750322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YoyBcTKf/eowDUgfYTU2q5ldvWbEXr4DJ0qkj2nIEM=;
        b=lycF4A4v4MF1VSc2NEiVnBeBMg0uwXctcyRudzBzDCS4TjyPhEPWFSRM5HFNzB84d9
         Xus2y1q9GCoTsa3fi02bjRFjuPAP2O7bKsGXkzzKyvjdujvOKfHJQGEgqGrT8T9GRMOu
         rE1Aq/6au8FTXn3+hQcDnVX5JsinZe4gmo3IviGBY10jNm3a11H/deaIBqW59009Xq8H
         ngsNuXKmypZH/QYd9cmIrt8UqpmhkJByBOJ2OyhQDKhLuHnG6a6+vO+45KKG+z4h1pud
         mwkulVYORVElrKunUsXr+uGw+1VFpM/c0pICtLPUVxSv/QJ6SnCStka3h4fxMlAU/08+
         OoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772145522; x=1772750322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2YoyBcTKf/eowDUgfYTU2q5ldvWbEXr4DJ0qkj2nIEM=;
        b=dNxGLbD+TPlt7sODJK5G6UxYUTNqxWHP0s9K0GInJevVcfTTRwFZinOHCMsQTfpMtP
         I74MUb0Jz2ttyltyDJ7mYslx4q9LsO0BuOTDAhbv38bw0WaS1rBN+sJLkku41xqsFU8p
         ymsHleqoEs7JK5sACvC/DjPlwuGnSq1EALWDfXOELN0+/LKQU6Y1xZw35FoEuNl9gRWn
         z1YqG/CGVHefeixX+dzi1bFPX0jLB2wuQOB3wewQdWgbGmfm/n7Q+8WWTeWi+2BJLHjj
         6WCmGJS2eYnuQj+ynbAZuVX6tXbViMll0Gk2twZLaxxi8elsNkfjjIfeHskspnlP/viY
         moGg==
X-Forwarded-Encrypted: i=1; AJvYcCUUADFybHKoqYEfk7a6YpZojmvUpJxk7Whim/Xy+OfhmU826cH+TGWTFdaI/GQBkE4bGgusVfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDWePnkPxTfGkshhp0Bxi1zot1P+NZ4b5GcUG/zzfM1v9/WdWQ
	dwUgvFhR1KhN36IkzkQmiyKS9qMot6LJvnzBskbCyKJvgUcRLNeTI3r7DAmoB/xpbwjC/WdTx2O
	Z6aDQOGuONGe0EtsuDLIH0NFzrSN0buCRwEbpfx2Q16WRmIRX9HrRMLso
X-Gm-Gg: ATEYQzy7b4GSGio3J1Dgf2s5hbkg9mgNlQwSDVcRkXsBroMAkAOY6IMQjVjRQfO1Hxd
	vS0l2zHyHbL+im59jRymKugP7rZ09jWibISCXEJdCpMm+kLtUcIb5ffzn8GoVruiKY/ltRW1v8R
	RMGppce9pqn37KrtqJ7JvNG6Eopu/r5VqgPnnnsWhCCkzykwpFOvf2ntQsh1dC3r+F95BVk0MST
	qojeDI3DMamNZcp3ppfFf+S9sW65inPpwxI/q+ZEl3Hy0x6lQKYuooqJ1K8n4d9OYEUFV39cGnk
	WyX8pHkOIq3xuuM8s/4GVyRfljJi1sG/cDMQaUH0SUQQwbuAhSaxlZV7nnSLT3/+VtImAX0a
X-Received: by 2002:a05:7022:3a08:b0:127:1492:e370 with SMTP id
 a92af1059eb24-1278fc289d1mr319331c88.5.1772145521779; Thu, 26 Feb 2026
 14:38:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226041213.1892561-1-edumazet@google.com>
In-Reply-To: <20260226041213.1892561-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 26 Feb 2026 14:38:30 -0800
X-Gm-Features: AaiRm51Zue1EbGQE_wxMGBmuE7VfZ8bdOqiFp4Uu3j1smcU0nglSSaHtOQ3YbPI
Message-ID: <CAAVpQUBPTfb31S3V7sH=o2Hmnj-O+U0+kuq1aBGfV9_f0oMeUA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: inline skb_add_rx_frag_netmem()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-261619-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C832A1B076A
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 8:12=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This critical helper (via skb_add_rx_frag()) is mostly used
> from drivers rx fast path.
>
> It is time to inline it, this actually saves space in vmlinux:
>
> size vmlinux.old vmlinux
>    text    data     bss     dec     hex filename
> 37350766        23092977        4846992 65290735        3e441ef vmlinux.o=
ld
> 37350600        23092977        4846992 65290569        3e44149 vmlinux
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

