Return-Path: <netdev+bounces-45918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7448D7E0639
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD87281EBF
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727521C6B3;
	Fri,  3 Nov 2023 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="XcEcBB1q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B13FBF4
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 16:17:14 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F6B111
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 09:17:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so30627831fa.2
        for <netdev@vger.kernel.org>; Fri, 03 Nov 2023 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1699028228; x=1699633028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vvmhYmC/QbC7oGEFnKNnhecSmVQk2QJI2kNmzL6pHrc=;
        b=XcEcBB1qMCVLeTU1P/QbGU585BqdFMB10sMyximesPBJR5glcQyPm0tzYbDQ4Y4nZR
         9ssWFi2xxH6f8LqvS285NOc/JW/aj2rSNzRZ8oxg81rxVjRefjYYQRm+HTfE3HypFjDn
         heST+cASc/aQlYO/yxvz+vrhN7ICT7iVprGhR8Emg5VPxCaXd8nXUC8+vb/b8k13LlLq
         kocSro5axgKeJNRbPcuQtVk0U9DvmjOKP76zAhnXo7IrTdiLVXek4S2916bFNSL989eR
         Ij3Uv6DIh3i2xgWfPvraQIzA1eagWZKrfRKVXh3rVNiLiLLoFecLNug94Ct6Jc/0H71q
         J0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699028228; x=1699633028;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvmhYmC/QbC7oGEFnKNnhecSmVQk2QJI2kNmzL6pHrc=;
        b=xF/alHCZ1bOoZu9ldITcN003B97CfHEmvNmebnWgBgKF4gUwxBxr1UVPmofVMF3LPu
         hbPElKVrswVaxSSYBSTvQ4LclkIzRcht9rdj8GsuXQNjUtBD0Jt2GydAefa7asKuWnIt
         oOqBho6/NR78GpeZGYfgVe5fWRpsnano5MfbBp29VRFWvTr1mh5iK08S5tgVmQG8Xj5l
         6s6yCjMgCRwLPPmX6lM5MkhDAdWyhAXJD7VvBNvkS/MyBmghMOfMp4XZgefg9kmr2lCt
         KuTCnegfcHl8u5pLPxyiVuUPsVoODhztcTg22WO9+Luv3U9WgNGc1XgOL/REy22A9CJn
         m4mQ==
X-Gm-Message-State: AOJu0Yx65DT/y6mGnIAEGxZtSZ5Ca95IZAK/zyJkLM8ng0uKv31Jxzjf
	Nf6lh/rNNHAyowE0LC6CnWyVlQ==
X-Google-Smtp-Source: AGHT+IEaPofX1b/aGl3GBnYi8tDM/yoFU7InvWgNuWPGwEzpVfu8963R7oC4qeAXhh5fumtEIIFCdw==
X-Received: by 2002:a2e:8217:0:b0:2c5:1eb6:bd1e with SMTP id w23-20020a2e8217000000b002c51eb6bd1emr16584966ljg.43.1699028228352;
        Fri, 03 Nov 2023 09:17:08 -0700 (PDT)
Received: from ?IPv6:::1? ([2a02:8011:e80c:0:bcb3:c564:df72:fc94])
        by smtp.gmail.com with ESMTPSA id iv12-20020a05600c548c00b0040641a9d49bsm3022293wmb.17.2023.11.03.09.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 09:17:07 -0700 (PDT)
Date: Fri, 03 Nov 2023 16:17:07 +0000
From: Quentin Monnet <quentin@isovalent.com>
To: Yonghong Song <yonghong.song@linux.dev>, Artem Savkov <asavkov@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
CC: Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH bpf-next] bpftool: fix prog object type in manpage
User-Agent: K-9 Mail for Android
In-Reply-To: <a115f76f-f53c-42c0-918a-b88d34c3f54e@linux.dev>
References: <20231103081126.170034-1-asavkov@redhat.com> <a115f76f-f53c-42c0-918a-b88d34c3f54e@linux.dev>
Message-ID: <5E56CB57-0162-4402-93E1-917635E68458@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 3 November 2023 15:34:05 GMT, Yonghong Song <yonghong=2Esong@linux=2Ede=
v> wrote:
>
>On 11/3/23 1:11 AM, Artem Savkov wrote:
>> bpftool's man page lists "program" as one of possible values for OBJECT=
,
>> while in fact bpftool accepts "prog" instead=2E
>>=20
>> Reported-by: Jerry Snitselaar <jsnitsel@redhat=2Ecom>
>> Signed-off-by: Artem Savkov <asavkov@redhat=2Ecom>
>
>
>Acked-by: Yonghong Song <yonghong=2Esong@linux=2Edev>
>

Acked-by: Quentin Monnet <quentin@isovalent=2Ecom>

Thanks!

