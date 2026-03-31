Return-Path: <netdev+bounces-273603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCKiIgu7y2kpKAYAu9opvQ
	(envelope-from <netdev+bounces-273603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:16:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4955369559
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A33A1308D3C0
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313EF3BE162;
	Tue, 31 Mar 2026 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cb1nLBCQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F63A5E65
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959008; cv=pass; b=kFBrrHSBEQkKlMOLh24jmdQT4IPBCE4HzhldoAOT9YXYd0AWDqCDB0Ed/glNRDbKppkTunPjR+GjUVU7BIAILbXaiTJCCBNB0nGlHbjaONU2J445kzuJ3WF/SGEepRMNa2grGvd+Jod4huDUyUJbUx7AL1F4jOwmNRftGMdI7r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959008; c=relaxed/simple;
	bh=vJMq57/wClwnNY5dpjMmFEdGhUe5I2y5Pp76zTkHmIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuNjTU2oUF2X5D/Qd7HDynSFImFaFPDO5m9VGzM//jUfSqN1eTmZJt49RFkr12rIWFfbmBTmKIpNozH0qr9B6g6ez/zb40KXX9jFRQs+PXVzqI4C7nRPHzgguTtksvIlkaHIKXUxxV/mw48+9DzTaH1/6fkb2ZQTM5YQm7f8mpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cb1nLBCQ; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb5c9ba82bso1119787985a.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 05:10:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774959006; cv=none;
        d=google.com; s=arc-20240605;
        b=hQlgHmtXaYqD6STto6jztFbTiWzndIUDnWi5MY71Xfx/6H+A37GarwEXMrcvkRxoTZ
         M91ctFu7Z+EwDpOc08mAcK9rbzZ5B7M3ULsOroQ9AYPvAPlRCCdaku+Y0OxKyO1IVRnc
         66iQ7GZYIh+bgsWnRslEryacO+AIRq4nw5TjORgGeP/cJmOeR3pc25xeN+HF/bUAk3sz
         zkTLSUJNOXiVyHQqoxvfmoSw6A0WaTo/Q6PP6s0XFZLZp7ICMEzO9iIyYb/ohH2yC859
         0RjTtOR06dzxQiLQ0ZF9q70m/zUj4Urr/JPG9+LUdoofVjTUcZSsV6xSC0z2SFKbgWre
         2f8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yn95I3ICsqrJ7jTfACKZcGf3ErmbeIE6oN1Rzg5BGvE=;
        fh=AyP4bLV3bPD/2MCDIfhXVxo54GHeFF87SCO1h6KYv1A=;
        b=gf0WVV8/kL0IecZHb+YukN8P0NoYCD/nUddNNx9hDFW95nuGfDXT9x66+kHRvRs3/P
         optJ0D9umyZsWJPMnRxtR9ySy/BDaKKm7cjCTK1Qz22Dgke1NthIMS5UQXimsU+ahCmb
         /WxAUCQKUl46C08AyHca2xpEVRlXCDKJIAo9z1LaPhclrY8PWVMCLvm7JEBJjRnkJEG3
         o63v7Y4n3ZCzrZUd59qpzKxFMEneetgqW05WPe87cjjBxq/fxBwTXivCjMRpPSkniSL/
         U74e/fJacfc5+Ir6ddx9Jdsry9dnj90yFs4ja9Vc5BfE4BK8dLX4hi7NMSb94LnEIc9s
         Yywg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774959006; x=1775563806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn95I3ICsqrJ7jTfACKZcGf3ErmbeIE6oN1Rzg5BGvE=;
        b=cb1nLBCQAvEDcEZ0oYNNa7odmFM/8M7oU107QGoOshNacCNL5HgbFFh6GlTV3Nb+XW
         OtyQOSn1kA1n4AHWhGLQcyG2TVi/xJdKaaTelBl8aUJV11diX71mTx6puMZHigfqe5W3
         oJZQIrKsId6AiNvFpng5Bf/cKSIKxbsixJ2zyBlccuXjeROxk1smWQxVh/r31smmGxvy
         GeN1Dun26GQWz6pEIQc15qa+R20yhVbB6ALh8gzs4AlFjVrzJfxTsGod1nVHzjq+mVDk
         uDpdyqqEZ72Y1KIz2x+DzOdMZ6svtuefW4eSj1pndAqsbE2CmlsmkBkcxgPJztirHGlO
         STZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774959006; x=1775563806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yn95I3ICsqrJ7jTfACKZcGf3ErmbeIE6oN1Rzg5BGvE=;
        b=kaBiaLja2kH2CyGgaGvEy0+FDvz/6aUIByMB/7GNsrKBN+iZS70zmTQ3LKbyw1nvqD
         Cjj292a6AFzn2oL431MMZjyOjYqY9FatoCCGEjT0YAo01RED0xtmUfxq/quqtJHzGhY+
         m0+mFnv8DFrDRRecQklHPHA06ZNUMolxMv2/gce345GB4LrojUHzEQ6viUI67zPNtqL3
         p3/wC3C1FxQ3xUZUJaZZJ0kgvvjckBed86FYTNh1n+Vy268jiX1gHO8pQ5fPGbdgG1UV
         yxRA9jXRP2ZSiV4uLcWNWQiOUYdIsvMQAHf31cugklvW0knWG3y2ULg65vbpTkKl4xee
         2emA==
X-Forwarded-Encrypted: i=1; AJvYcCWM4oAVb28aIRCalFCoLY5ECj2/1SP1h1ZLpjp6wSSKVTWNGLm8N094SIlE1YI+KA3fK6CpkmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQNhkrAu+KHP25Sg3X8W+6AUfZotGyjc65ebTpYVkM5t/lcFJ9
	398il1g3AXBSS+RInDntNtPxggALDbLorjsbJhsgiD0sRprMYVOwVuqboro82n0UnAzuCZr9TH6
	nb2W972cGQtgiYm4zt1XSHtOg/lgOiPqlfT0eCNRY
X-Gm-Gg: ATEYQzw+SnZregdV2PF+W61v4hJAUf/i0+HLGgNVAxLI0Uk/ylJVWRLVJxigPuEDW5C
	JjJOV76jPVRxYIlyknCJdmUHbz7acxT5vv1SYOYBYfvvYxDi3XgpsfW2U5kGii6368j2SnTiVSM
	tN2XecH6wQaNkvCSxxzYOfmqKRmG1VtU2MOKX6wjWn+B+5l+xrMRk6Ygf2Bxe5mBppqBhgyLyw9
	gWPq5QXZLWWlcGAZxF54Dd22q7oAMOUY56Cr87ybSAu+JT6fbBXCncSELheVt34aii2xndrxf0g
	GYj7yEyVogBjL3w+
X-Received: by 2002:a05:622a:18a8:b0:50b:49d4:e54 with SMTP id
 d75a77b69052e-50ba3808c8amr227341241cf.15.1774959005183; Tue, 31 Mar 2026
 05:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <51dfd8ae-dc4e-4837-9b00-c596c457117e@redhat.com> <tencent_E0D6D670591F561A4020EBC8283A39504E08@qq.com>
In-Reply-To: <tencent_E0D6D670591F561A4020EBC8283A39504E08@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 31 Mar 2026 05:09:52 -0700
X-Gm-Features: AQROBzDEqmRIa2Yi7l3tWriGwFhEZnjVNvF-nnSSZAR0RhLYkDOxGwy-86k9FBQ
Message-ID: <CANn89iJXEmFMh7Sj4H-5xqjz1+h2Fnt8SBXbCnRFvezGsbfvpA@mail.gmail.com>
Subject: Re:
To: Wang Jun <1742789905@qq.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gszhai@bjtu.edu.cn, 25125332@bjtu.edu.cn, 
	25125283@bjtu.edu.cn, 23120469@bjtu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273603-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:email]
X-Rspamd-Queue-Id: E4955369559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 4:15=E2=80=AFAM Wang Jun <1742789905@qq.com> wrote:
>
> Hi Paolo Abeni,
>
> This is v2 of the DMA mapping error handling fix for ns83820. Changes sin=
ce v1:
>
> - Added queue restart check in error path to avoid potential TX queue sta=
ll
>   (as pointed out by the AI review)
> - Adjusted variable declarations to follow reverse christmas tree order
> - Switched from dma_unmap_single to dma_unmap_page for fragments
>
> Thanks to reviewers for the feedback.
>
> Subject: [PATCH v2] net: ns83820: fix DMA mapping error handling in
>  hard_start_xmit
>

This is not how a new version of a patch needs to be submitted.

Look at https://patchwork.kernel.org/project/netdevbpf/list/ and
compare your patch with others...

Thanks.

