Return-Path: <netdev+bounces-44478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 806207D836F
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 15:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18D94B212D6
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 13:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F2D2DF9C;
	Thu, 26 Oct 2023 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KrcaQJKF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3162D7BA
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 13:23:06 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580F091
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 06:23:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9adb9fa7200so185839566b.0
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 06:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698326584; x=1698931384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfGF1wvIaczehv06ebByBZL9NMqVboZ+F6Zxo+zfw5g=;
        b=KrcaQJKF5Mx1m9EB+S/aiw6P7Peorb8BVFsrA2AZaME9cJfQ0pIrZIZtVCFd1AfHW+
         3TUQF8uBD9AzjLJYYFLVwINWmN06eg7rv+FDHCRNtwxdIK3soyyRMGUmqe/m4HQYBhrZ
         2El7bl4gGry4vri6qYozPYlRvQNOU/O40R809bDscvX/No305TzlXRYCj0cNZusC0/mm
         luVUiXC9g11JPB8sg3N3M3vt2e2n45t6T0tA7HYeqkKoCRIctpTf2iOsu9r3P7Wk7/a2
         gFG7SZUm+ym/AvkxMEkYTklRYUKY4fzAtJKKv45jSBnXa/UtTh7SioZvnbUb/VhVrFqD
         nAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698326584; x=1698931384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfGF1wvIaczehv06ebByBZL9NMqVboZ+F6Zxo+zfw5g=;
        b=LpM+GRh0FtTsnLTIztYlFaEUXTrWphoPKkf0Zg19kphcptM4NVV6wQ9AUcSwquyrJI
         b3rBUf4ILFb+MpU6T04W+/7Jjj/3SP+CxKDxPPAPNExWjn5XZszIyDxVQMDMGMb5bIiJ
         W/bFR7wFqwqf4B7rl2pO4NKWhxNWF6hGyiQrzj6wWKHu/blFWTMR5lOzSM/cARctyRz4
         yGcUE/6pFk6WyHh7NSBv4G0BlE8143Iehh1E4WRa4mqstYfvmviqPwu8SzVNJWlVlBgV
         8fwB90xA4RBumsE3np2r4AO+s1SRMAmE8bU94d9kxagfVEa/ZEMvS8XCtZhF+fTTNmD7
         TcdQ==
X-Gm-Message-State: AOJu0YxzgQGSAH1qJN4FhjC9ygbHVU6V0/joD23dJ/UqZ3PfJXUOlV2o
	onfayOF6rOdlRfCvIDWAefOkoA==
X-Google-Smtp-Source: AGHT+IFzYYXh7b6O1wp2FSPKvSqNw+ZLn8IKGWJKSb4LLePgHpa6NYbUrLvtBU5Tqmqq2ikxrz1WAw==
X-Received: by 2002:a17:907:96aa:b0:9ba:8ed:ea58 with SMTP id hd42-20020a17090796aa00b009ba08edea58mr2636546ejc.30.1698326583879;
        Thu, 26 Oct 2023 06:23:03 -0700 (PDT)
Received: from localhost (mail.hotelolsanka.cz. [194.213.219.10])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090660d400b009a1c05bd672sm11472502ejk.127.2023.10.26.06.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 06:23:03 -0700 (PDT)
Date: Thu, 26 Oct 2023 15:23:02 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
	ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com,
	kuba@kernel.org, andrew@lunn.ch, toke@kernel.org, toke@redhat.com,
	sdf@google.com, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next 2/2] netkit: use netlink policy for mode and
 policy attributes validation
Message-ID: <ZTpoNuFuE1BYLqeB@nanopsycho>
References: <20231026094106.1505892-1-razor@blackwall.org>
 <20231026094106.1505892-3-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026094106.1505892-3-razor@blackwall.org>

Thu, Oct 26, 2023 at 11:41:06AM CEST, razor@blackwall.org wrote:
>Use netlink's NLA_POLICY_VALIDATE_FN() type for mode and primary/peer
>policy with custom validation functions to return better errors. This
>simplifies the logic a bit and relies on netlink's policy validation.
>We don't have to specify len because the type is NLA_U32 and attribute
>length is enforced by netlink.
>
>Suggested-by: Jiri Pirko <jiri@resnulli.us>
>Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

