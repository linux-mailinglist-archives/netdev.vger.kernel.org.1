Return-Path: <netdev+bounces-93209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1888BA94A
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 11:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E7CCB20C32
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E9A14A0B1;
	Fri,  3 May 2024 09:01:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D4414BF85
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714726869; cv=none; b=GHInrDQMGdD+2b1wM7Kl0Gbh31Tfdk5xQK22+xkG+llL6kx9hvuVr0zYUUNAfZnWbYasjZaCOtG0fU69BWgtps/BwESii2o5x5jw4bi2z9XQFxCY1JmjdpGcF/T/G/5LDdlEntT7izoK93MnMq3fC2gS6ylMfOCviPXT1VvqoNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714726869; c=relaxed/simple;
	bh=qY30bWutxP6TiDaNwJlO9HhdYtKsrpisi5CQeqxc0/o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lcnS1sGYZ/Z7gaTlnCxzSbbB6/KWV+yW4xkxkg6wcK0YGI/FFc0kIRUaQRWucYXrG+J/du7PwVJHALc3QB6vhlBVd/g9BMq8Y+9fTkSpER27gI+XnJ7t5DPArA+KuDK24xCoFB9JzpJLBljsiqjlCyGB8VwtkGVDAZw67jpzCeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a598eb35ab5so101841266b.1
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 02:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714726865; x=1715331665;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6v193Y0gzs2buOXKwRw53DM/W1/oJJLtawgUHQOUH8=;
        b=vQ/uSt6XjXzq7YEzf++tdOp9RFl8qGszWCFJvqD9tuEsi0Xw7xclGRaGlaqhU2XeTG
         hJCBr4kr5H1OM3n0RDondK2uqluYuRRPThXe8gvVKW6Mb9PB10OVg+AsZ1JLSv+WJZmB
         dgPrgbO11Fy4K4j4YUvYn3JuS0enP7gJ9HUi6P3t5bNG9WHKnG0/2O3BCkG2T3dc4Njg
         Kp84YvFZfuAggFCG2GPTxZr6t8BAdL50nxTHEtuuy5lpRs9aENKTgXNhrFGbao+xFws7
         fj9fPNp9Nt2twYXRnmTQmEQelMMg6nwX8cpqQ+9MCtnTAdnYH+NrkA+mM/TKVnZtbcEm
         FgpQ==
X-Gm-Message-State: AOJu0YxWtCS/Kx60riF8B8NyVRu/vaUrtEnub6pNz+qMvmRnswQ/axPf
	rrEkFXkA4Xgdd+2FlrbQfSwMalOWP9Ko6Jxx/PoYSypQ7bq8cU/TrjtsIA==
X-Google-Smtp-Source: AGHT+IEfK9a/zzXmaJdm8O32rI/drGl1scjjlFQNLChYwp2/nrITxEgHHvXDf17uk7ZaYcL2DhSJrQ==
X-Received: by 2002:a17:906:5655:b0:a55:4afe:a9c5 with SMTP id v21-20020a170906565500b00a554afea9c5mr1246765ejr.25.1714726865357;
        Fri, 03 May 2024 02:01:05 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id xh9-20020a170906da8900b00a597ff2fc0dsm898424ejb.69.2024.05.03.02.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:01:05 -0700 (PDT)
Date: Fri, 3 May 2024 02:01:02 -0700
From: Breno Leitao <leitao@debian.org>
To: michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com, edwin.peer@broadcom.com
Cc: netdev@vger.kernel.org
Subject: net-next: bnxt_en failing to load
Message-ID: <ZjSnzp59tX54MVaC@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I am testing net-next, and my 50Gb Ethernet is failing to work, looking
deep I found that bnxt_en module is failing to load. This is happening
for a while (~week) now. Is this a known problem?

This is the problem I see:

	bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Able to reserve only 0 out of 9 requested RX rings
	bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Unable to reserve tx rings
	bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): 2nd rings reservation failed.
	bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Not enough rings available.
	bnxt_en 0000:02:00.0: probe with driver bnxt_en failed with error -12

This is the device I am testing with: 

	# lspci -v -s 02:00.0
	02:00.0 Ethernet controller: Broadcom Inc. and subsidiaries BCM57452 NetXtreme-E 10Gb/25Gb/40Gb/50Gb Ethernet (rev 01)
	Subsystem: Broadcom Inc. and subsidiaries Device 4520
	Flags: fast devsel, IRQ 16
	Memory at 38003fe00000 (64-bit, prefetchable) [size=64K]
	Memory at 38003fd00000 (64-bit, prefetchable) [size=1M]
	Memory at 38003fe10000 (64-bit, prefetchable) [size=8K]
	Expansion ROM at aad00000 [disabled] [size=512K]
	Capabilities: [48] Power Management version 3
	Capabilities: [50] Vital Product Data
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
	Capabilities: [a0] MSI-X: Enable- Count=32 Masked-
	Capabilities: [ac] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [13c] Device Serial Number b0-26-28-ff-fe-a5-36-50
	Capabilities: [150] Power Budgeting <?>
	Capabilities: [160] Virtual Channel
	Capabilities: [180] Vendor Specific Information: ID=0000 Rev=0 Len=020 <?>
	Capabilities: [1b0] Latency Tolerance Reporting
	Capabilities: [1b8] Alternative Routing-ID Interpretation (ARI)
	Capabilities: [240] L1 PM Substates
	Capabilities: [300] Secondary PCI Express
	
If this is not a known problem, I can try to bissect if this is useful.

Thanks
Breno

