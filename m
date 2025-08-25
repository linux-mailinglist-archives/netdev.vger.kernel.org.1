Return-Path: <netdev+bounces-216574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA45B34987
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3622A4474
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D62308F38;
	Mon, 25 Aug 2025 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ITlRynbT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8856308F12
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144803; cv=none; b=Ue+o5TsDLjTXyyVweF10dUmYDuB/6njZoGzfUL/8QL4haTp7W/XAuyjobbdKneDp/RevwX92JkLbfu0FHgBCLhrr6MDNGUXAX/DLroXkyio6NWdVqh1fheClT63U6PsIUvdO1Ciyq6kdMAFDj9SLHHb25gZykQIWCwPPZcUf+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144803; c=relaxed/simple;
	bh=8l2ob5s0SW3L4DBTShaRvUdBqnl6CxmDW+jG4sXB4Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0VnLaRn/r1IwBvUNYNZJ6jBtalDst1uE/C92ZUbwImOKzHOLTnMxL35vo0XVydDmBrKVftl4BxyVFwRRH/WV2DIpLA9D6n7qN2EUF+2tb2C6yAcHlUIHGsNr99ydPgeTr2NbQufqcFBoxYf2BS2CDiAJtpi4CknL4eCye2Z6fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ITlRynbT; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-88432e27c77so127005739f.2
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 11:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756144801; x=1756749601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPX6yU60jhIfnL6Ozavo2arzeCaU+2cK2dM9pPf9WrE=;
        b=GOfFiSC47jmGiOZ92R92g5pHIIqRwyZk7PAKsWt/0pqAwJGUo9VyNAeRcVgDQVrKRw
         m522tKXlF44wsrSaS4L2271aLjTtVlXPa1SBkbiKqG3MA0PA0fSofdAXDraLcA43VDAn
         Cqft+PyKNW6yuP4LM4CFCN9xCF5gk2swssAasQmFKW7jDhJiafSkdrzKSpuwCNzeixk3
         JpMn2P8CMb33y3ChK9WjgMpy1Wp3YJU2SCHMhEzM6PKAiylcUmiZazKW2WuacgqGYQvE
         XvgjlAdNxZ+fyUoRfUzeaZqpHF+1M7XWVlsv724rVFuxJVOG8JArPNpIenrjLTuDCNU7
         OuCg==
X-Gm-Message-State: AOJu0YypsajZ+ankk/pLphr30iODFoIJMFQQt7wBvQJLtJArDtDhr8bD
	bug9NcLQ3J1fV8MTNO3WuyTw0yviLCW3ZVh0y4r9ujbJx6AFwyv8z3k4zA971DHrOKSw/r8pKwL
	tfughwlBsf0slhXE3tAUwKRr56Poi58YXV6vyAqH4fJ3ScCC+s4QG5Pb1Ai5MclMRus9kw+V+Lf
	qdv0XX0PgdfAqLWIl4MpZX2blBjGW/iR7DvDUNtxb1O9Pq1rJ0uHFZD5ebBoVB2u7ZTNV0oUK+O
	U7Fg2/0MQo=
X-Gm-Gg: ASbGnctoDS8bZ1G30PRn7AWsw2lAbfNd5nsTGvs3z6zir40orHN1dt8dtn8KaXiBNvp
	cVu8LvqlbqAocHOoJkvXz4ljbHgibf0KS+f5ZV2tGFP1RE51RMMeBYSLCTEIDgpCWupopprVWqw
	37VBew68Ny1YdqTbr70FLmGNAU+wSoMAVsGfIhoZt8mFlGIroSgphqzTav/QeJO2/X1nVVJKQRN
	yScxIO3UEVI47Z//eZ+bWCfbW2iyyEk/6ZE0rcTZeAvEh2IhJzYCIfDY9iwnk6t+FBa9sxqqZC4
	hia0osA+dcWKDkiG2XYqoFDOo8fl7X1ZF65slWXwJl9o7FIGshIh+ktjJ/IzztVSi6MODRknWzs
	8K/EM0FacZ3HIWxxevZcPa1YZ8tfGXY40dpQqLochTfCVY+FFRlB6iJX6JhQRAU4ZTddOkb/tPM
	h7Xg==
X-Google-Smtp-Source: AGHT+IERTXlM2nllBNX7vKaKoo/ZhzeEqs68aRwwN2RX/QT+5nOapzlL3YpEFbHARVaGqMvhJhV/Wda12HwZ
X-Received: by 2002:a92:c265:0:b0:3ed:47c1:bbd2 with SMTP id e9e14a558f8ab-3ed47c1bd7fmr43170215ab.31.1756144800528;
        Mon, 25 Aug 2025 11:00:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3ea4e83c0f5sm6332675ab.35.2025.08.25.11.00.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 11:00:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b10990a1f0so135302851cf.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756144799; x=1756749599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPX6yU60jhIfnL6Ozavo2arzeCaU+2cK2dM9pPf9WrE=;
        b=ITlRynbTkk9EpDM6XR0mmW6hW18ZeBFIRrKug6lnUYGycLVB0M+F/MXiUhMHACRI7u
         aH1s7XV5U+f8rqjWOTvAOwy03eBGDku/W8f6Zo6FKKBRThuJw4xenSQGAjPcwo8A1tAP
         dS9EupvDB5UbromrrF5xyC3XTk4R3IjTDS9J8=
X-Received: by 2002:ac8:7fc6:0:b0:4b0:641a:ddde with SMTP id d75a77b69052e-4b2aab56f09mr134271191cf.59.1756144799245;
        Mon, 25 Aug 2025 10:59:59 -0700 (PDT)
X-Received: by 2002:ac8:7fc6:0:b0:4b0:641a:ddde with SMTP id d75a77b69052e-4b2aab56f09mr134270911cf.59.1756144798695;
        Mon, 25 Aug 2025 10:59:58 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf36e7640sm527498585a.59.2025.08.25.10.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:59:58 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 0/3] bnxt_en: 3 bug fixes
Date: Mon, 25 Aug 2025 10:59:24 -0700
Message-ID: <20250825175927.459987-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The first one fixes a memory corruption issue that can happen when
FW resources change during ifdown with TCs created.  The next two
fix FW resource reservation logic for TX rings and stats context.

Michael Chan (2):
  bnxt_en: Adjust TX rings if reservation is less than requested
  bnxt_en: Fix stats context reservation logic

Sreekanth Reddy (1):
  bnxt_en: Fix memory corruption when FW resources change during ifdown

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 +++++++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

-- 
2.30.1


