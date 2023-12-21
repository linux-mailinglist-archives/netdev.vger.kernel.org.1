Return-Path: <netdev+bounces-59448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFB881ADDC
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 05:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883B71C22D6D
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C4753B3;
	Thu, 21 Dec 2023 04:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FjUhTdGJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211728BED
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 04:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3dee5f534so10844805ad.1
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 20:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703131523; x=1703736323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7R3J1Lil/osNc9pPKzBboKF7PSiHb0b/OWQwZHZAl8=;
        b=FjUhTdGJhXg032h2B9xQm6K0fr2cS/rAWm2KUx7d1R/0hReff7DFsNrdJm2Scy55JU
         xQfMACKxOLBbAp4a+20v6cTFQvFC3sEHLoxhUNI7JG7NU4gBEeiUykT/UWlhWnTEhmqc
         GwA74XpKMHgCpa05nE9W7OduCgMq4JmbUFOGR6tjD02+DJOq1au+QNAzUyl0so3lMNK6
         pONOTLAMTgN5ixOiuSGjymGqNGAi9QOeHJBLtv2V4xuaks3xLrLHpt+c/2cPt+AHRSbc
         mLJ183DHWCFyQ80rNgVQqotc90x1J/ZrC7gAE9zcw3+ixwBZSMKdTZgzaFbGYvTcyMxJ
         QQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703131523; x=1703736323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7R3J1Lil/osNc9pPKzBboKF7PSiHb0b/OWQwZHZAl8=;
        b=X+DIfv7AGah5Pm6uP31ujDHlBTncxIE3HfzLXbh/B+SSzEHMfMPHe2HiEh7waxT2eV
         DppOcRplAq8q0Zz3MUiTfKhoC9lDheeC/M2yHkSSgbaWuYIfROvZqMsC/SSv9VhWezZ0
         n/1IEimm0rhSJ2tar7DM2kCNg1zakPR6+pCq2wT/kZeKH7Sr/dgvPFJNTsI7Vt7FzgIk
         c/jy6chMwUF+TpDnEapDSeVW+iS0SKauRQaND1gXw+tkjprXS/RLhPKUbFnINH3c4i1R
         0cawsWO0FG23jeNgoBbiLak7Q5wRyf/228eV2liqW9xBpiZWqFCKCGHnJHJgVz+tTA65
         MDtw==
X-Gm-Message-State: AOJu0YwBEwgU5ZqNhp0Nw/0iLrSGNFxUnJq31QARi9YLnRzrrTPaoHkV
	tc56JUaLxA1mOu1gUWkmzy0Bc2MQe8LW8w==
X-Google-Smtp-Source: AGHT+IEpG/uYhNtRyOtiRkNkDv50QmS8HXqXOT07z07VaStxuM/whGxa6bTlxS69p47a/O2YPrhF6g==
X-Received: by 2002:a17:903:1108:b0:1d3:a423:8584 with SMTP id n8-20020a170903110800b001d3a4238584mr97169plh.47.1703131523323;
        Wed, 20 Dec 2023 20:05:23 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id z65-20020a636544000000b005b856fab5e9sm541402pgb.18.2023.12.20.20.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 20:05:23 -0800 (PST)
Date: Wed, 20 Dec 2023 20:05:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>, Roopa Prabhu
 <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 08/20] bridge: vni: Remove
 print_vnifilter_rtm_filter()
Message-ID: <20231220200521.077249aa@hermes.local>
In-Reply-To: <20231211140732.11475-9-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
	<20231211140732.11475-9-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 09:07:20 -0500
Benjamin Poirier <bpoirier@nvidia.com> wrote:

> print_vnifilter_rtm_filter() adds an unnecessary level of indirection so
> remove it to simplify the code.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Tested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

