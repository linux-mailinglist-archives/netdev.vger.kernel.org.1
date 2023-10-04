Return-Path: <netdev+bounces-38013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB037B85BB
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2C93528162F
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69681C2B6;
	Wed,  4 Oct 2023 16:53:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43B61BDC1
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 16:53:16 +0000 (UTC)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F33AB
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 09:53:14 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7a8b839fc0aso1033719241.3
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 09:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696438394; x=1697043194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trfPvWlc2Z4z1gMaB+tLFdm/beJC1nNivy0/WxwIxQ0=;
        b=bNXQXmV0zD08F6kKmpGWVHS9LZQTmtobzoonvvPknnc+av5IWlE5IOzLD1VyE6Ajrp
         6EwbW9JZJnFkMByayCOFR9ZwgPLnfG3roV0UuuPVZrZBDogxyUTwK5+BEj3lxUrq3YjA
         GZCSwzqicVUzcLaaKGFEaDLjcTGYM3mtrTu/Sol5qdhsJ6RSgZgQnMD7cPWPC2/SMGzo
         sl4VCrb+bLBAJPdwhYxdPFP74E1PHHTxaVRx/WiSzwioXf/TZPl8D0+8hOsY9KBgj3YR
         A+AJJ6FMMYg6h3fPTPW/LapnEdQYJjOvcPb3lP277yo7YKijsAeQDU7DeDO4rVM6zUZ5
         O/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696438394; x=1697043194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trfPvWlc2Z4z1gMaB+tLFdm/beJC1nNivy0/WxwIxQ0=;
        b=Fr4juvibc69JC7tyo3bzo6jSVmPyOhZ9rLhMXacQdHWfOW6lwcN1OfzxpeADKDk5qS
         jrin/d0lWV21oz0DM1VU4hSUwTmQSHNxTvOx+p+wBgwrmuD96T/kfpY5Of3dE3I1iHwV
         CTHmicBzMCLl221hoJK7oSZAxxv0NkxyeJXi4bYJWf8DQOp6y2AblNo2IiGG2kD9kN1j
         J7OpuC4Y+xlNoaboUCXPb0QA1SR2p7EnpET3+Dq6uYc6GRAHgBOdLH05eqyf7v4xxSyr
         cwCahsXp/Mtd5kcdKMsDaNwP+Jbj3SOiS2Co6MyCf3vgwgCsAAFXVu65VLdK7TwuHokQ
         Epyw==
X-Gm-Message-State: AOJu0YwudvDenH2+0Y/WBbFzNNYotGUXGgsshNYwEjxU38txFFf8Q4M1
	caPf98hFGFCChCms5ygLHlVkh8shNewmlsRxcXGsng==
X-Google-Smtp-Source: AGHT+IEWCgvkfIvZj/B7L0SlMZXQCDSAI4lzHhqLl6NWb7K31ZFWxOCgbPKOxLXuc0v3xopPwsLqVue5HwUql+5JYvU=
X-Received: by 2002:a67:eb49:0:b0:44e:9f69:fa52 with SMTP id
 x9-20020a67eb49000000b0044e9f69fa52mr2366498vso.22.1696438393670; Wed, 04 Oct
 2023 09:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004110905.49024-1-bjorn@kernel.org>
In-Reply-To: <20231004110905.49024-1-bjorn@kernel.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 4 Oct 2023 09:52:35 -0700
Message-ID: <CABCJKue8MW8dsrPG0PFC245jBRFx00JqcCEjzs=Os3TXwkcWFA@mail.gmail.com>
Subject: Re: [PATCH bpf 0/3] libbpf/selftests syscall wrapper fixes for RISC-V
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Bj=C3=B6rn,

On Wed, Oct 4, 2023 at 4:09=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers") introduced
> some regressions in libbpf, and the kselftests BPF suite, which are
> fixed with these three patches.

This series looks good to me. Thanks for fixing the issues!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

