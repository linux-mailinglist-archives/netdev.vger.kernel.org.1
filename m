Return-Path: <netdev+bounces-47034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214D07E7ABF
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B72EBB20B5E
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BEC11CB7;
	Fri, 10 Nov 2023 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nobJaIP4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F9F11CB2;
	Fri, 10 Nov 2023 09:24:58 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4685598;
	Fri, 10 Nov 2023 01:24:56 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507a29c7eefso2312364e87.1;
        Fri, 10 Nov 2023 01:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699608295; x=1700213095; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7OZame69zbnU6L0OiwcXF8HyElhtG8ssWy3tTMbANA=;
        b=nobJaIP444AyT058uc4ydgVR6un+oQHC+oif2obgDWmTYneuU3AUED2zYGoLUqIz+e
         8eN8AhFIb5y5HqQ4YqocWSsxPLA/+i/9GR/4bypK919DpVWdOBaUFXEu2rcWhJ61QgLC
         RTRHqE1sgBx4w8DX7ud16FNE1tkjJ4VdIeqBAzyPORar/oS9vFMj35YQxyRvpMZOvuoZ
         VtrrI7USF3wr6u0Re6BH8fDtYXwDuxFbS/c60szYs5JEegOfpn22UbHeiIAvHVUSVQ3B
         FAsvIAQO9rcCh0r5utpKXU20Uzngla7OGUlDLRXTCga39RbUWTDubn07w+gr8AfVzyvF
         whDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699608295; x=1700213095;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7OZame69zbnU6L0OiwcXF8HyElhtG8ssWy3tTMbANA=;
        b=u8CnPplH+q6yEcZGo2RcqJwZ3HILqidhw9++QVFqqkiX1qldE+OEPtL9wcZNAhGUx3
         0Rh1/wLSNtkZqbxqYR8oURdVUd54+kO/jFpW8qZmDtHNM5uUyMdUzSt5+w+wyRAGVAfv
         vcSmm7GJx1RS57pgIumfozgSCg4AFuocI0KDnJ/nKQO1yJp84RtP/3aoecFfjR0B9AA5
         eiYu5O1GM3g0GhFsN9S7ggQF74bkgpGQMVSW+erfEhwQHu/RDGx4szpo3BYuYyczb6+S
         9Q5KImrpxkKENzFZTsPc2GGxQM9qmW6n0Mzwv+L9XCtl1uoplPVe01pO1+vKWkj629r1
         HUQA==
X-Gm-Message-State: AOJu0Yw07i20iU5FYxJX+Pg7j2ZglHV0uayB42dlggSIpkrVF/3l6P5B
	qbWXdL3gM3Q2D2fdlmEsp0E=
X-Google-Smtp-Source: AGHT+IGwQwDdOl9KvwvxD8XdI4QBBXBUdAEJUoKzciMSK+M2sPiKdejWczdhDwISGn4QdKA4/yFfUw==
X-Received: by 2002:ac2:58db:0:b0:509:494d:c3d2 with SMTP id u27-20020ac258db000000b00509494dc3d2mr3381216lfo.32.1699608294497;
        Fri, 10 Nov 2023 01:24:54 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:f859:75f8:9bf:1a56])
        by smtp.gmail.com with ESMTPSA id h12-20020adffd4c000000b00326dd5486dcsm1486945wrs.107.2023.11.10.01.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 01:24:53 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,  Breno Leitao <leitao@debian.org>,
  linux-doc@vger.kernel.org,  netdev@vger.kernel.org,  pabeni@redhat.com,
  edumazet@google.com
Subject: Re: [PATCH] Documentation: Document the Netlink spec
In-Reply-To: <20231108174306.47a64bda@kernel.org> (Jakub Kicinski's message of
	"Wed, 8 Nov 2023 17:43:06 -0800")
Date: Fri, 10 Nov 2023 09:23:50 +0000
Message-ID: <m27cmq3qs9.fsf@gmail.com>
References: <20231103135622.250314-1-leitao@debian.org>
	<875y2cxa6n.fsf@meer.lwn.net> <20231108174306.47a64bda@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 08 Nov 2023 13:27:28 -0700 Jonathan Corbet wrote:
>> I do have to wonder, though, whether a sphinx extension is the right way
>> to solve this problem.  You're essentially implementing a filter that
>> turns one YAML file into one RST file; might it be better to keep that
>> outside of sphinx as a standalone script, invoked by the Makefile?
>
> If we're considering other ways of generating the files - I'd also like
> to voice a weak preference towards removing the need for the "stub"
> files.
>
> Get all the docs rendered under Documentation/netlink/ with an
> auto-generated index.

FWIW the index could use a toctree glob pattern like we do in
Documentation/bpf/maps.rst then it wouldn't need to be auto-generated.

> This way newcomers won't have to remember to add a stub to get the doc
> rendered. One fewer thing to worry about during review.

