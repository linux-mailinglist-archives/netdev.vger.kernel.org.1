Return-Path: <netdev+bounces-31143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1FF78BE07
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 07:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3F1280F5A
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 05:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EB410F1;
	Tue, 29 Aug 2023 05:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4966110EC
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 05:50:30 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4392DEA
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 22:50:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68730bafa6bso3272299b3a.1
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 22:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693288228; x=1693893028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcdP27FxWbCVzpNQH5EfpxOowBc5vRZl2DKcFViaqQ0=;
        b=aY+3klMJetWGJt45qVInvlHrt+MSKmttOM7e2Fm/ZojYDZL8RcBcxqxb0n48jGRL2F
         CmpktEL+7vufiAgCPJ4bQXlSszQP3qpxm57HqX81PkTKXPeYp7T0r5lA2McpfpOU1gys
         lupNHMkDYQKkUzpwvImfW7QIfVNQZsiH93Ko+yjeSUFgc/Xgx/SJOOKo/9/lIDGn7P5+
         Lm+9cRjRoOindryud3VkSzGjaCZVzV0JAf1kvLWb5nbTEnOKQE792qvrTnUU2PV8gk9G
         Inu88vPcPVywcSH0TzMSuY4j2h9MksXazP5VT1YJVNn719dD2soI07oZ+05ZsmUqTDKh
         +dIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693288228; x=1693893028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcdP27FxWbCVzpNQH5EfpxOowBc5vRZl2DKcFViaqQ0=;
        b=HRDT+/DkKOJQoMwcUyhtGRFp3np0PZF4VbCdNI4pV77DWvhn6UOcA4Vn7UFxomL6cV
         PNvfO6D1Vn90cShK7vFxRGAXDFIq5bOuzPLTYZWwh8TkF5B8+BoqzBsAHAE+fOmU3kEv
         f9kDVUvQ2pK1cYHAOcVT4iAVfPh90xCWwtqFe+NWDjvSWsIGCbJb+MZkW3THT1AnpOzM
         QXOAsVy36blg0uZWnJMAHRsJh0mq5aP4OntO5t2QVUuRRwv01+ALBsqPclz+Jcza4dyG
         20rfv/qlQam0mA2t35IywUWDcharhX84FmO/NrwKH9uyXvr2MLpak3dnMVkF8FTHfyTq
         rVZA==
X-Gm-Message-State: AOJu0YzhM344wNp5X4IgVzIlKbZlS4uLsOB/ApQDRIXp1dtIeEiYP4UQ
	t8Bx6d01hfhMAR/+ndC+5NbIw7lt638H47wj
X-Google-Smtp-Source: AGHT+IFybkTwSy/ci19RZcn4w9jKTFr4dT+WUGshMk+3MFdjQIWx8A/Jsm2SrB9gNxuj0GlxAr99RQ==
X-Received: by 2002:a05:6a20:8e25:b0:13e:90aa:8c8b with SMTP id y37-20020a056a208e2500b0013e90aa8c8bmr2774171pzj.4.1693288227840;
        Mon, 28 Aug 2023 22:50:27 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78719000000b00687087d8bc3sm7897713pfo.141.2023.08.28.22.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 22:50:27 -0700 (PDT)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	jbohac@suse.cz,
	benoit.boissinot@ens-lyon.org,
	davem@davemloft.net,
	hideaki.yoshifuji@miraclelinux.com,
	dsahern@kernel.org,
	pabeni@redhat.com
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 0/5] net: ipv6/addrconf: ensure that temporary addresses' preferred lifetimes are in the valid range
Date: Mon, 28 Aug 2023 23:44:42 -0600
Message-ID: <20230829054623.104293-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230821011116.21931-1-alexhenrie24@gmail.com>
References: <20230821011116.21931-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Changes from v1:
- Split into multiple patches
- Add "Fixes" lines to the commit messages
- Use long instead of __s64
- Ensure that the valid lifetime is not shorter than the required lifetime
- Ensure that the preferred lifetime is not longer than the valid lifetime
- Update the documentation

Thanks to David, Jiri, and Paolo for your feedback.

Alex Henrie (5):
  net: ipv6/addrconf: avoid integer underflow in ipv6_create_tempaddr
  net: ipv6/addrconf: clamp preferred_lft to the maximum allowed
  net: ipv6/addrconf: clamp preferred_lft to the minimum required
  Documentation: networking: explain what happens if temp_valid_lft is
    too small
  Documentation: networking: explain what happens if temp_prefered_lft
    is too small or too large

 Documentation/networking/ip-sysctl.rst | 10 ++++++++--
 net/ipv6/addrconf.c                    | 21 +++++++++++++++------
 2 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.42.0


