Return-Path: <netdev+bounces-229765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CE1BE09C5
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01AE3B0F37
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78A129AAFD;
	Wed, 15 Oct 2025 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="nhQr6AaA";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="QoABl/jd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-edgeBI204.fraunhofer.de (mail-edgebi204.fraunhofer.de [192.102.163.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD51D8E1A;
	Wed, 15 Oct 2025 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.102.163.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559512; cv=fail; b=uSjP4qPRemWKunvejSw8yGrkiCznhS3g11cz/1GpkZgZGC5CEGujy+HP4pdfQW84gfylB/VqRaRV8vb7qA7hver0Mp10zVFhfIRV1P+wwFQLzE+9424C38wgno7govbYKlVCsKxijYu1kbsPaGeEV2cFGFBgQNu39rXtyuzN/Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559512; c=relaxed/simple;
	bh=cwxkrD0ZoYryLLsGIU/B3422LpXlG6yhWe85jLAiL8E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bFeUST1Jd4PU7deCfG5LRDrNw5l+DXRaeyL215sRB/8HYCjpKP2S5kPapup3eQig/c3md2YEGV6WRMQ+9CCCQnbCr6t7T55FRWnhOeZI2sRGk4vW+Yx72//oCafevjwhL/bDtXN6hCE1wab7/fAwtXgfoGnF2SHbc+7b+ZyuSco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=nhQr6AaA; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=QoABl/jd; arc=fail smtp.client-ip=192.102.163.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1760559506; x=1792095506;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=cwxkrD0ZoYryLLsGIU/B3422LpXlG6yhWe85jLAiL8E=;
  b=nhQr6AaAz1zVSWa1NuZtyL8kif+y34SRFgdUnJAbcH9Hf2baV30cNUxP
   qj9J2NL5t7uGCFxDhxBhVWRhmPJyuygclftz++YkVuuiu7OMLrYJGWIPO
   TVWm/O9p+x98tzpKrcDYdFVnk7/WW0Bh07nP7c4j0uex42MHiCVeztBXa
   8OqbFj40U2l1uN4+gAFOXqtompSNfeYlYS3Uaa1Rpc8v0CZpbkbeHQyUa
   f760VCOHyp8hOLyfCB0gk2OfRpYYoo5Lo5VGxPUeCiDax8GwGxC8DEIGI
   P5A2kZ0GQ5g/tohga4gzxKxRVSqgQ/4oecURw14xg9o497NnAmkuMoyAW
   A==;
X-CSE-ConnectionGUID: 8rzPM3lYQjO1izRfEnPcKA==
X-CSE-MsgGUID: RuCrkAXjQxiJ3SwDVjlxXw==
Authentication-Results: mail-edgeBI204.fraunhofer.de; dkim=temperror (key query timeout) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2G3AgDpAPBo/3maZsBaHgEBCxIMQIFFC4JAQAEyD4Fph?=
 =?us-ascii?q?FWRc5xIKoErgSUDVw8BAQEBAQEBAQEIAUQNBAEBAwSEdgqMTyc0CQ4BAQEBA?=
 =?us-ascii?q?wEBAQEBAgUBAQEBAQEBAQEBAQsBAQYBAgEBAQQIAQKBHYYJRg2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQINKH8PAQ0BATcBNAImAjMrAQ0FgwIBgiQEEgM2FLFog?=
 =?us-ascii?q?TKBAYIMAQEG2yoYgSeBIAMGCQGBEi6DfIRVAYR8cDuHDIEVNYJEb4RYg0aCa?=
 =?us-ascii?q?YM0hjCCVo4pSIECHANZLAFVEw0KCwcFgTAzAyAKCwwLEhgVAhQdEg8EFjIdc?=
 =?us-ascii?q?wwoEi8ccz1Xg0khaA8GgROBGoI6BQGJQx8PhWQDCxgNSBEsNwYOG0MBbgeSF?=
 =?us-ascii?q?IJ8AUlELIFoLCkLlkewHweCOIFnjB6VORozl2CTC5kGIotsgXqbDgIEAgQFA?=
 =?us-ascii?q?hAIgWiCFjM+gzYTPxkPjiEMFoNehROKKgGwPXYCAQEBNwIHAQoBAQMJgjmPZ?=
 =?us-ascii?q?YFLAQE?=
IronPort-PHdr: A9a23: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
 iM=
X-Talos-CUID: =?us-ascii?q?9a23=3AiyDvlmj2DCBqzmMxIsba2WRNXjJuImfP9FKLJ36?=
 =?us-ascii?q?BC0EwSa+vR3KWwKhHup87?=
X-Talos-MUID: 9a23:SuwZzwYIcW2NouBTjSLHnjJLBMVR86WMU3sSvasEv9m0Knkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,232,1754949600"; 
   d="scan'208";a="13454352"
Received: from mail-mtamuc121.fraunhofer.de ([192.102.154.121])
  by mail-edgeBI204.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Oct 2025 22:17:00 +0200
X-CSE-ConnectionGUID: iU9Q1t3nSIy37AxBJ2XbKw==
X-CSE-MsgGUID: GeTLRtrmSXGYgH6Oz/Hdwg==
IronPort-SDR: 68f0013a_JbajCjpDMn9ZqbJuZ9PA3d6KadgeOIOJ9TsqooyZ64GYavS
 zeE7qcUvKp1+374JYUv1uX34zvwJ84aMkztsMIg==
X-IPAS-Result: =?us-ascii?q?A0AvAADL7aZo/3+zYZlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAlgRoGAQEBCwGBbVJAATIOXIEJhFSDTQEBhE1fiHaccoErgSUDVw8BA?=
 =?us-ascii?q?wEBAQEBCAFEDQQBAYR9CownJzQJDgECAQECAQEBAQMCAwEBAQEBAQEBAQEBC?=
 =?us-ascii?q?wEBBQEBAQIBAQYFgQ4Thk8Nhl0WEQ8BDQEBNwE0AiYCMysBDQUigmABgiQEE?=
 =?us-ascii?q?gM1AgICDqcXAYFAAoslgTKBAYIMAQEGBATbIRiBJ4EgAwYJAYERLgGDe4RUA?=
 =?us-ascii?q?YR8cDuHC4EVNYJEb4gegmmDPJBegXF4hwlIgQIcA1ksAVUTDQoLBwWBMDMDI?=
 =?us-ascii?q?AoLDAsSFAgVAhQdEg8EFjIdcwwoEoUEhCYrT4QYdkFYg1Mkaw8GgRWBHYJIB?=
 =?us-ascii?q?QGCFUADCxgNSBEsNwYOG0MBbgeTVYMrAUlELIFoLCkLlkewHweCOIFnjB6VO?=
 =?us-ascii?q?Rozl2CTC5kGIo1mmw4CBAIEBQIQAQEGgWg8gVkzPoM2EzwDGQ+OIQwWg16FE?=
 =?us-ascii?q?4oqAad9QzMCAQEBNwIHAQoBAQMJgjmRLgEB?=
IronPort-PHdr: A9a23:4Rf0IBH9rT5SiTZqAnQyfZ1Gf3FNhN3EVzX9l7I53usdOq325Y/re
 Vff7K8w0gyBVtDB5vZNm+fa9LrtXWUQ7JrS1RJKfMlCTRYYj8URkQE6RsmDDEzwNvnxaCImW
 s9FUQwt5CSgPExYE9r5fQeXrGe78DgSHRvyL09yIOH0EZTVlMO5y6W5/JiABmcAhG+Te7R3f
 jm/sQiDjdQcg4ZpNvQUxwDSq3RFPsV6l0hvI06emQq52tao8cxG0gF9/sws7dVBVqOoT+Edd
 vl1HD8mOmY66YjQuB/PQBGmylAcX24VwX8qSwLFuRPAA8fL7wql8fpG0TSBYJL1VblpRjfly
 rtHdyLpmTUuGAYSq3CLlNxvnJMO83fD7xYq+on9SoXSNvYuY/z7W/lEBkddXeFTbANMDaOeV
 JIQKvURHNcfiZfzqWYytD7uNRWJGO2+9yVZrzys5LQr2uomSTv7zSweANs3jyqMltLpJqI7W
 OKb6K2V9GqcbsJTh3Ct066LSQ4qnNKKR78zf8bg0xURJwbnjVK1sMu5Bg255vUfuVTA8+xbd
 +6VtDF4mi8u/WWFw98Vp7HSv6kfzWH46Htd+58PJMKTS3InNI3sAN5RrSacL4xsXoY4Tnp1v
 Dpv0rQdos3TlEkizZ0mw1vad/WiTqPRuEulWvyYPDF4g3xoYvSzikX6/Uuhz7jkX9KvmBZRr
 yVDm8XRrH1FyRHJ68aGR/c8tkes0DqCzUbSv8lKO0kpk6rcJZM7hLk2k5sYq0PYGSHq3k7xi
 cer
IronPort-Data: A9a23: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
 Sifq7Ox3l2r
IronPort-HdrOrdr: A9a23:m2aqTKrWaIY1o/nrGwljMi8aV5vdL9V00zEX/kB9WHVpm5Oj+P
 xGzc526farslsssREb+OxpOMG7MBfhHPlOkPMs1NaZLXLbUQ6TQr2KgrGSpQEIdxeOlNK1tp
 0QDJSWaueAdGSS5PySiGLTc6dC/DDuytHVuQ609QYLcegFUdAE0+8vYTzrb3GeCTM2c6bQU/
 Gnl7l6jgvlXU5SQtWwB3EDUeSGj9rXlKj+aRpDIxI88gGBgR6h9ba/SnGjr18jegIK5Y1n3X
 nOkgT/6Knmm/anyiXE32uWy5hNgtPuxvZKGcTJoMkILTfHjBquee1aKvS/lQFwhNvqxEchkd
 HKrRtlF8Nv60nJdmXwmhfp0xmI6kda11bSjXujxVfzq83wQzw3T+Bbg5hCTxff4008+Plhza
 NixQuixtdqJCKFuB64y8nDVhlsmEbxi2Eli/Qvg3tWVpZbQKNNrLYY4FheHP47bWjHAbgcYa
 ZT5fznlbhrmQvwVQGZgoAv+q3mYp0LJGbLfqBY0fblkwS/nxhCvjklLYIk7zQ9HakGOul5Dt
 T/Q9pVfY51P74rhNpGdZ88qOuMexjwqEH3QRWvyBLcZeM6B04=
X-Talos-CUID: 9a23:DrWFA2FZvVWX7MtwqmJmyR8tQ9x+dEb83SyPCl+SKzxZQp6KHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A1KY8dgzbO0Tsv07lIPnx6sQH5VSaqIujNGQ3jY8?=
 =?us-ascii?q?DgPmrBCNQZRCPyxS7XYByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,306,1747692000"; 
   d="scan'208";a="29721715"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaMUC121.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 22:16:58 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 15 Oct 2025 22:16:57 +0200
Received: from FR5P281CU006.outbound.protection.outlook.com (40.93.78.51) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20 via Frontend Transport; Wed, 15 Oct 2025 22:16:57 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJ6wHzLVXAn9/wYfmH6Oh0SbFV5b6DKRyc05nZ9oZbsTM8MHEx7BOutJn1/TCUhj1JoJMraTrGkm0Eyk6DANoYmmKOJsVR8dMCi5JPlw9MZh/bQ8mtR96NyDjbXLXjPfxxMhOMwdomvwz+m6sm8+qOlhGw9uPsiIWiOYd/ohhcFO4rQ83SrrupOXqlNF6vJ0wKl20RXf9Opd8CmNz7jGmajlAfglQ3I0StfuE/qcSS6/x/+uO/59fx3PmcNVrWdHLKS4mDGePgf+RztVhHu4E1vNYpQhggFFdaqkizaUP7L6y/YPKL2CZA1ttX4gABgnGPifWyoa6t4KdPxfD0IWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR58R5I7/xSaus57kpa5wk/MtDWUiyzAGPC3y4vxwxY=;
 b=xahvJ8d/5Mrek8AawznOutq8+QfaxPCnC1owv4s8tIF3s5mzT5LJyzTvpsef1XoRNZ1TQT9vojACtGkBFXLbXCu3+KstVT6sIjkMKKPIK3rxB79t3FtLWriQl4i7+0DL8yvutc/hg+/jLdspsjdVmjCtEUvwaD+nbj4taLgw1p5ViuCpq9D4MfEGhDho0DIaRDVTPbfqm2ZOta6oRvUUR7b5GHZshitXctZCvQMGm88eo5xp96TYXIR4dhohi8pxKINZTMSaTMjTNNSf50KAZKRWP3qxY0iVmQnI09xdWxIcM7VGNAN/WMYaUHMP8x+Up8nAM2uww16kNhEapCYRWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jR58R5I7/xSaus57kpa5wk/MtDWUiyzAGPC3y4vxwxY=;
 b=QoABl/jd8u7NNB6+EtkOjSGegHJSqwMwxIY/NvffUTqM8XtMtf9UryA+2Qqyafo0RUyHVwaQW60RotzmAajFLl5Q77iYm6/8SN+SvcUKnre+fdYr4VXmJkoMq/4QVDXyzbT3tnSJdRW77YF775BmpQEPsQCboYTu6LSqRiwCkT4=
Received: from FR2P281MB2073.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:38::6) by
 FR3P281MB3152.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:5f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Wed, 15 Oct 2025 20:16:56 +0000
Received: from FR2P281MB2073.DEUP281.PROD.OUTLOOK.COM
 ([fe80::30b3:7e69:815d:8bc8]) by FR2P281MB2073.DEUP281.PROD.OUTLOOK.COM
 ([fe80::30b3:7e69:815d:8bc8%7]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 20:16:56 +0000
From: =?UTF-8?q?Johannes=20Wiesb=C3=B6ck?= <johannes.wiesboeck@aisec.fraunhofer.de>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
	<kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang
	<shaw.leon@gmail.com>, Vlad Yasevich <vyasevic@redhat.com>, Jitendra Kalsaria
	<jitendra.kalsaria@qlogic.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <gyroidos@aisec.fraunhofer.de>, <sw@simonwunderlich.de>,
	=?UTF-8?q?Johannes=20Wiesb=C3=B6ck?=
	<johannes.wiesboeck@aisec.fraunhofer.de>, =?UTF-8?q?Michael=20Wei=C3=9F?=
	<michael.weiss@aisec.fraunhofer.de>, Harshal Gohel <hg@simonwunderlich.de>
Subject: [PATCH net v2] rtnetlink: Allow deleting FDB entries in user namespace
Date: Wed, 15 Oct 2025 22:15:43 +0200
Message-ID: <20251015201548.319871-1-johannes.wiesboeck@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::16) To FR2P281MB2073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:38::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR2P281MB2073:EE_|FR3P281MB3152:EE_
X-MS-Office365-Filtering-Correlation-Id: b404224e-cbfa-4dc0-3260-08de0c27c9e3
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ymc4Z0pKMUhWQmdKZE56VVVzZFhiUHFob0U0K3k5V3BweVlGekxuQkJaMHZq?=
 =?utf-8?B?L0J5UlVidGZLZHd2d0Q0S200WnJmUWZORlduSXR4YXdrK1pOeHVaa2FoOGRu?=
 =?utf-8?B?NU9GOG1FMFdYdWlJSXdkQ3VlRENmT2lBZ0VGOHNITUZIK2lXQ2x1NmNPMVFi?=
 =?utf-8?B?RlFhT3JKR1UrTHRONzRTeVdaeFNoRmhpU2l1Z3JmVDJWK0MrYmh2Rm9wWGlV?=
 =?utf-8?B?bEpRZjIySm40a29yUk5VRVpGV2dENkJOd2l5RzN6V1UzQitTeW1IWHYvVGZW?=
 =?utf-8?B?MDhOaWpsR2xLREljR255dGExMlN1VFpaN0doaUxlcTV4S0o5MVd1cnpPZjFB?=
 =?utf-8?B?UkRMV25UOFZvU2t0SmYvYkxJMlorWitmb2ZLSU9IMW5mTENIemhlVnd6OUJQ?=
 =?utf-8?B?dFpsMUFCRDRpdmpESjdpWGVpRk13dkpZcS9aWkozOXhiRWx0MU91cVBka0ZR?=
 =?utf-8?B?a2hHbk9GR0lua3YxMy91dFZzY1NxVU9NYXNweHptRHhjYVdMNVlHV3dzcDI5?=
 =?utf-8?B?dG9aaUFoQlhRU08wem42Qk8rUGtaNkdVeU40ZkdVWmVyZG1hTWRDZy9Ka2VH?=
 =?utf-8?B?K0pRMjVzRS9pMGMybE95Ry82R1FGWHBGSVRnN21IdTZ3ODdCWTFwc0ZhUGNI?=
 =?utf-8?B?VHNRZHF2UHZoMmNIcXRuN0Z2M2twMTFBOUJXVEZteHRQcTB4R1haSUNFTGMv?=
 =?utf-8?B?aUNHYzhBRVdiZGRNNmxTQWloWHE1b3N6UFVqSXZMSm5WSWhiMGJnVG5jM01x?=
 =?utf-8?B?bDA0SGk2MXNBVG9QTk82TXpvUG9pM1RqRHN0cTZiR3JDY0pGRTB5a09DY2l3?=
 =?utf-8?B?MUpDNEtta2dtNUtYZWQ2ZmdJRUJmVzJ6aFN1TXNkZGxwTHA1a1c3dVdTTGZO?=
 =?utf-8?B?RlhxcEdQSlRrcWxhcDF3NTl6UmdzQlFXK1ZNZXJ5WGxJMnk1emQ2aktjaHFO?=
 =?utf-8?B?a1c2Znp3Q2NpNXo4Z0ZmbmQ0NzZQYlRjNFhEWlBLdzJCcjFrZ0I5Uk54cnQw?=
 =?utf-8?B?SENBRzJDQ2R6ZmthTk9SMy9JcFBPbk0vaXRDT0NaeGVZazFZMVRCSFk3QmlI?=
 =?utf-8?B?VStBWGZDcTFjV1IyT1RxUXZGeVBvbkZrNVdCa0piRE0wUkxHdmlDZm14ZFNQ?=
 =?utf-8?B?U2FiZHRLT0hSRlhnSjc4NjVZZlp0MnBVTFJtS0k3WnB2VlFMRVU2WnAzZzl2?=
 =?utf-8?B?Q0FzeG82bDZteEN2RTA0ZHpzalZHN205Ym1lTTNRTm9vbTcxdUN2VkFCb25O?=
 =?utf-8?B?dlE5dXR1OFlESlEvNlhsY3R1dTNlSDlrVFVzaFJEcE1KNEZWSzZ1L0RXcExz?=
 =?utf-8?B?RzVZOVJQbHdqVTI0Z1J3ZVRSYktpVm1FZmxjV1RUN1prRVY2NytpZ0dXdmgw?=
 =?utf-8?B?YWlGQ2lBNjlDdWxFWmJwQjRuSTBWaDY1WVcyVHo0bC9Fc3d0R2tJYmpWRXhr?=
 =?utf-8?B?N2R6ZnppN2VUekI3TzBrYjEyTVRlV2xZTmw2clpPdGY1VzNoNjZZc2tDK3lE?=
 =?utf-8?B?bXF1aWVISFc2cmxDVW5aVEhFUnNCaWJITnZwRklTSTcvMk16MFdiWFQ0YXJO?=
 =?utf-8?B?SHp6RTJEOG5ZUVBiUGtQVS9WNEdiTk9wRGVnYmhKUkR6azlFb2hpS1hNMDBm?=
 =?utf-8?B?a0ZTckY2SmVEekZPMU5CRjRwNlNMUU03RkViakd0dTRrcUgwdmlxRE4wb1lQ?=
 =?utf-8?B?dXdFTlR3WWtXMTVxcWpmbjFnMlJoYzlQUFVMOWdud3lGOU94aFErZzlFV2xN?=
 =?utf-8?B?SFhLL3JvSHZKMjJMTGVXV1R6eGxRWDk4THJ1QlA5K1Y2N0huNDR5ZHR3N0JE?=
 =?utf-8?B?ZVBFTDVZTWxyRjBjanNtNUZrbTlMVUNSR2Y3SVRpOGc0RWJmcEkyOGFLK0xn?=
 =?utf-8?B?RHkyeCtwUzJwQ20yeFBxMEVHcTFrb092NGFWUEtQYkcvRmVvcEJtRE1nQ0g0?=
 =?utf-8?B?Q0grczJlS2hNSE5mK29BSEdnYWs3WjVZZy9GT0FYZHAySjNoemR1MWtGZjNo?=
 =?utf-8?B?NXZUUVZsTVpGbXFTTHpSNU90WnpiSzZiLzM0RWxwcTN3SUliN2dtNWJHTHZi?=
 =?utf-8?Q?nU/pvB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2073.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGVOZWwrN3dIUU40WTRBSDd5YXk4M2N6N3VJbVR3ajhWWXdQaVdhZTBlbHVW?=
 =?utf-8?B?aGdOUm9XVDFOa1Y0OXNmRDhKYnFxejJLVFg3blZrU0ZBZnZkN0NmclNqMUdG?=
 =?utf-8?B?d1hYSm5XdThka3JzTExxaDl2d0ZEQ1VPRU4yZzRmYlA4N0FiUVk4QjhDcXpC?=
 =?utf-8?B?NnhuZHFYVnExVCtPQUpQamhSMWt4aFg4dE1rUUloU0NsbnZta0VGR3lJWUt0?=
 =?utf-8?B?WWNNOXVHem9UdXNQM3FrVjhtak5vU3ZVdXRva0Y4dnVwOUxVREV2aXdNamx2?=
 =?utf-8?B?N0RBVVVPOFRIVjJpTHZ1SDBLb1JYeFU5TUdFYVZPTkJFRjlGZDliWDRyT3Zm?=
 =?utf-8?B?L0twelpta3ptU3NNdVdCcERCL1ZpMTVReHlDSGRxRWV4YUs1a1ovQlhkeWxS?=
 =?utf-8?B?VGRkN2xqODAvcG9ORTY1RU9ScWVoekFIZG1KeWcvRUErWSsvNDgwYjhRSkVn?=
 =?utf-8?B?QXpnb2NaVTBaOGFBK1BubFdhSjM1eEpxOHVDdHpqVUViYXBpbDZEaGR3UHBv?=
 =?utf-8?B?L1pRYUpINDJQOTY3SS9xMHl6eVVuemRhUndVVHRjWkMvd1JFekJwNHA1TFNp?=
 =?utf-8?B?OTZVWmZ5TnhYMGR1UUJab1lzcnlLVklCUmlXamFSTXRkWmtZSHFQSDdRSkY4?=
 =?utf-8?B?eG5pcjB6ZGV4YVN1S0FTdHVOOFJPblZjbW5uYVlBOVBHbldTemxaSUExTkhS?=
 =?utf-8?B?Y2U4Y09ZTDE4L25jSjNQMVRKTXZBUDMxL0d3N2tZWXd3bHVGNFVRWFhrTUtv?=
 =?utf-8?B?QWVKR0t6b3BoT0dVd21CQzdSejJYQ1ZxRS9aeUtmeWpkOWVreE5oZFRiaS9y?=
 =?utf-8?B?TXNNYnFzcFJjRksxbi9xb0RXQWRld0N5WlFnVXFnZE9jQXBMdS9nQndSL1pU?=
 =?utf-8?B?STZ6clFRN3FkSkxhMUl3WmlqTDRESFUxdE14SGVMN3VSVEJNKzd5cTgwZFg1?=
 =?utf-8?B?MTFlOS9Kc3NndjJsK05UZEdSejBiNlhiTFFYN1BqRDVIYkh0RFRUdTIyVXVB?=
 =?utf-8?B?R3k0cUpvN0V2NFFGU3NVd0NDcG5YZ21tV1BJMkZFeVhOOVVRWEFOSXNuN3RJ?=
 =?utf-8?B?Q1loTjZ2YmFHczRESFMxR2d6SElqdnU3U3NIY29hc0hGL1VWYVA0Tm9aQ0Rv?=
 =?utf-8?B?V0JycnBWZmJmRmtmd09MMW5EcFMxRHBRbGdsZmJFekJjc0NXRVRzdE93bE8w?=
 =?utf-8?B?UnlrbzdUQ2RaZWNyd3NYbVVINGFQOXZzNG1tUEx4VVg4dmZNNUlmeTBGMytQ?=
 =?utf-8?B?ZDRPQ2IvQ0xvdkVFWkkyNnJoZ2hWVVNPWTJHc0liRktYU29ZYXhkRjFUZU1h?=
 =?utf-8?B?NlVvTXh1V2pScDRqM3N2cithZWhHTk5yVk11MUZ5QzY4aTZ3dks0d01YOG92?=
 =?utf-8?B?bWxCZlBNejdGTVNGVHVIeUh0WVREaGd0c3Vpcjd5YWl6VlRoSGYrNit1RWtC?=
 =?utf-8?B?akoyM1JmVVY1b0NCN3FJbkVlSi9GNi84RHpPU2wwTjAyNDBuamdHZGlVTEVD?=
 =?utf-8?B?TWE4TmtwZnRHUXpRQjBBN0MrZi9mekZsR0lMdnRjNG03OE5mZTlaOFVybkJY?=
 =?utf-8?B?ZjBiUExpdE41Q0R6MlR5V0FxOGJGNWFFZ2prRkZURkZxY3BGT01qU0doQ2I0?=
 =?utf-8?B?bzZHSWdtT1MzMEN2Y0N6Smpjb243UlJvMm5yejRDUDJ6eldRSnNuWXlaSDB3?=
 =?utf-8?B?K0hNbU5QdFBzWVEyNkxCTi9oU21wUDh5UFQ5Z1VsZXA5c0Fob09wWDFCUjJU?=
 =?utf-8?B?SG82blNLRkxkVzdaZlJ1L210OE1lbDkwZ3hlOGtWNmM2bHBqdkx2V3JDa1Jw?=
 =?utf-8?B?NXJYTTNZWmdVNHJMSSswSW5YMDZuNEdGYXRacnhEemw3UlpvaEFnVENCOUk2?=
 =?utf-8?B?ZmFGYW5DNnpTQ0dXY3JBZFV5clE2blptL1pqUWRXOSs4WUlBYTZYejRidnpt?=
 =?utf-8?B?MzBMNVB6aCtrK1JaL0h5K1NVNy9zdlljTjRQVU1MZTY1TGFpTG9nQTZBSDEr?=
 =?utf-8?B?S0JZZTRHS3YzUGNSZ2JVTXB2UllyZFRGUGRyc1BpYXZUNktiT0JYb29GL2JV?=
 =?utf-8?B?VCtrRjVtOUJEZlYxY1NUNFJmK2QwYzVtc0FTd2FSbGo1UGs4cUR6dDVQMEQv?=
 =?utf-8?B?d2VPRGNkTXRVOGMzOSsyc1I0VXFGMGxHcFZZcERpN29hNTUyeEplYm85ditP?=
 =?utf-8?Q?Qy/0hilyejEIB8ZPj6sKP8g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b404224e-cbfa-4dc0-3260-08de0c27c9e3
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB2073.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 20:16:56.5125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDLqLPzT2o894XdQ3C9Ya2hyeCy4IPar4u10i5D305TjQB8NCj+OXXmmRECGZbxNHMWcKCbxV7c5ApkDRCrSS8BSi3pO4Fx1bXmnCv1/4Cxee1ZmPKue1Xi4IovTzoIp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB3152
X-OriginatorOrg: aisec.fraunhofer.de

Creating FDB entries is possible from a non-initial user namespace when
having CAP_NET_ADMIN, yet, when deleting FDB entries, processes receive
an EPERM because the capability is always checked against the initial
user namespace. This restricts the FDB management from unprivileged
containers.

Drop the netlink_capable check in rtnl_fdb_del as it was originally
dropped in c5c351088ae7 and reintroduced in 1690be63a27b without
intention.

This patch was tested using a container on GyroidOS, where it was
possible to delete FDB entries from an unprivileged user namespace and
private network namespace.

Fixes: 1690be63a27b ("bridge: Add vlan support to static neighbors")
Reviewed-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
Tested-by: Harshal Gohel <hg@simonwunderlich.de>
Signed-off-by: Johannes Wiesböck <johannes.wiesboeck@aisec.fraunhofer.de>
---
v2:
  - completely drop the capability check in favor of changing to
    netlink_net_capable
  - describe intended behavior already possible for adding FDB entries
v1: https://lore.kernel.org/all/20250923082153.60030-1-johannes.wiesboeck@aisec.fraunhofer.de/
---
 net/core/rtnetlink.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 8040ff7c356e4..576d5ec3bb364 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4715,9 +4715,6 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int err;
 	u16 vid;
 
-	if (!netlink_capable(skb, CAP_NET_ADMIN))
-		return -EPERM;
-
 	if (!del_bulk) {
 		err = nlmsg_parse_deprecated(nlh, sizeof(*ndm), tb, NDA_MAX,
 					     NULL, extack);
-- 
2.51.0


