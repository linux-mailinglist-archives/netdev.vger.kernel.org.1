Return-Path: <netdev+bounces-288450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IMgOJ2FB2rR6wIAu9opvQ
	(envelope-from <netdev+bounces-288450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:44:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4FE557842
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AAAC30086F4
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEA33E2743;
	Fri, 15 May 2026 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="NHEQHmgU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C637B3F2;
	Fri, 15 May 2026 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877850; cv=fail; b=hxJFP+7E8zByM3i7EK4nNMrzhpNIpTVkXMf31XtFhKY2AmZDoDDIAbzLp+5bkMXEJpOPw+nSZBJlW9HPGjJ4m14C22a68aStqt7NlOeJb0AG3o0/K0XLL7MneIIDAmA/3kFIQT/Dwv62cUdbLOnt/ypYCAPVROxMi0rgwC6dNeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877850; c=relaxed/simple;
	bh=NjQ2/pBvry1JwL//Q0UwpOZb6OvEPD/Vun3HZHVbz3E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vh8HdsSG4bmL3heP1E4Zetzfwq1WRCwZ3DtSXrpqW0cLf/8rd8QiveunmHZWhfJSYnC4HGh8EyHwehJvJNr4FPT9hmpnL1k9uzDDh9tex4ITKbLQSBeFS6asSVPLJ/EVJSDcR+LfgqW+Y2Vk0YXZpYaw/pququb3kIqRTyNtAv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=NHEQHmgU; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=ces1;
  t=1778877849; x=1810413849;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NjQ2/pBvry1JwL//Q0UwpOZb6OvEPD/Vun3HZHVbz3E=;
  b=NHEQHmgU8CPIDCu7qYrUW1aKdsOFMdc8WGSLCcNcgTajfC3jB9IJ/I9k
   akco/ZzTY/rCS3OWTcPgFkzTc82zNGSFa8Ge7sJ61zGo/EOdQVeMNdqSD
   eAlHIXzFc5yJOa/tojtmmY7Qaujo3yN78lWFCm6dRXyRFHeDVIn+e74lG
   8=;
X-CSE-ConnectionGUID: Fw/FhbJvRVOuughnq6WzfA==
X-CSE-MsgGUID: zygyJxmWQcyFjO4qrZkENA==
X-Talos-CUID: 9a23:DNjp4G4RC9KAzUPaRNss2lFTNMAvUGPn8lDNPkC4D383d6+bYArF
X-Talos-MUID: 9a23:whqXiwnDQVZT+KeZ9GitdnpwJch5wbSrN3kGgLsEnJWdLx5zFhG02WE=
Received: from mail-canadacentralazon11021103.outbound.protection.outlook.com (HELO YT5PR01CU002.outbound.protection.outlook.com) ([40.107.192.103])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 16:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbYQ3/VCjNef+4GsPTmjxR70wAg+TgZeHXDZQ/0npc4Ikcw3LOcSrD1EZjTkKr0atUCnfLyVgEYAfHjOQQiUTwEgpv/mfjXlJrqlfb6gLFGBGkyYhezkC77yxJwFkSsJAckQXBwhiqf2Vs/nSy2CilwuK+RYrLj34er31CzKRbJfHstQUxhCp1rzxCXGkUFSdogM8IjyzIlXtalDxeXzE1mGBxDTBVmMXpfooeGjQI9BTAzfhWB5DXq8WV8tJUxf4N53M05HwELDWVY1oP1jcREGG9+c3tS8XVv8cK4PsMRDH/LcYQfCfqAf9PIiXevTDfHCNiCEN+2IZZjA1CHXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coPZNXgW5O9hkuD1SOtXT2VTJF1gCzVI5SY6oJ02LgU=;
 b=Rl5PVENEafa1eytrq6g3JvCHh7pQuBTVnf3p1Jbta9P90/Ybe98YeMStQSsw8NOF7F58T3UghMaAY9YL8oDz5QHMRTOn/lWxR1GyEz/7zsVluLlgPzGXAqK/SHyMUToh8H5G56M/uzgYg8ma9tGl6lijv//1nW0sSHfeocdS+47xojPjqCwro1gGQhgMHs0Z1L0nsDNxkcWdrEKtRJO/A0/2WdCnIuasEpp6dIcUg2mwwPHCYjQkBtA2JedHj5z/B5FvYgp7jFm9ekccLqFeCpLZTavkwhfnWgIY71SIbdsA1YSis66W+3p2PaolUXC1un/eSCnD+JeY49uwLYzmdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT2PR01MB10435.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.9; Fri, 15 May 2026
 20:42:58 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ec62:77d8:42d1:10fa]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ec62:77d8:42d1:10fa%6]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 20:42:58 +0000
Message-ID: <3563a311-f888-4419-8c7b-c847ef29770d@uwaterloo.ca>
Date: Fri, 15 May 2026 16:42:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: napi: Skip last poll when arming gro
 timer in busy poll
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Joe Damato <joe@dama.to>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Frederik Deweerdt <fdeweerdt@fastly.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <f0ecdde3-de16-47ba-b795-fe0042114e96@uwaterloo.ca>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <f0ecdde3-de16-47ba-b795-fe0042114e96@uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0039.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::21) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT2PR01MB10435:EE_
X-MS-Office365-Filtering-Correlation-Id: b74483ea-8231-40c3-8764-08deb2c28c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|786006|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Hx6azy3oTqPbkzK8oiQr/GGT1MUUPkK+g8PXlbov3yhMi6CLuYQzupVRLRYGCyGmTgd+Qs0YebddqFjFinsoddtwdWvrSD1mTP2N5EuQJhm+bPgRPS8uEhrK6prCzvyH9gpdu3X4HZVj6fDi6bEPRVBqdgPAhE4zYEm0GJUQYE8ClZfTK+Zyuok0vLKyVpNofOuC3WPkB703oy0FRnStfbquFphtrh9x2O6aSzKArXbMz1KrBCzeSa17Ti2NH82CRLrDs7na+oyZ2aRbQORaPTPsM/sObmVic01txtAF+xQ8+ZfnaNuB1haHQ0OOSeaDAQyhlwpJNYAssOfnzM3cHmtwx+YpzR11uKJgH/DtlgtwxfoKdoqapLYUxVMme2jPVl0s2JSEAkkkXhJ+bIRPq2zhqbq6vZ/gFRijnPdniEtizaxDHqrvqq2Dku2I01Bm2oJwUcOaUtuuWoIvwikcugHVJZ6FD4V820sT3SQZOxFwswjGaBWv07vf46TzfYWYyhEG3beIUXyKVawkKM7+JMZomWsH89qLxykN3nD/J4LH41MyQ6cAfLzL5EAdpDLxnc1uOKVm8EnTUnd2Qa5MCvARhgIAbZWxS+qa2h3UewIMY/Hx1Pdi554bgVnqlAtfCBuEwFivPhKAY3L5SKoh2bMZRE1rcQOxr7xjqKLgicjkBSpGnfhnKZhcQy6QzHcy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(786006)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WitJRVVLUDJHcFRnSXRoTmVNek8wNnViNG5ucnl1STdzcVZoVk1YNU9wQWVT?=
 =?utf-8?B?SGR5RDZSVHVVOHZ4R21hSDJFZTN3cGsvQ0l2bG5qelhjT2hBbWdON2xVay9X?=
 =?utf-8?B?ZEsvRnVnUnRVeFo1QWtzM2dSajNnM2VvemZCUnJGLzdrbEw0TXpqQlIwbTBQ?=
 =?utf-8?B?L1o3RXJobmpwYTFGcDFObzlUNklCQ3NkMnJRN0R5V1ExZW5Tekx6TW5WSTBl?=
 =?utf-8?B?elR5QmJYUmpHOEdaZjdNN043Z24ydUlMTTYxaG9XYkxrektuRVhxM1puc0Qw?=
 =?utf-8?B?SlpCSmo3UkgvRENDakl2VnBMRUNUNUlCdE9xMERJZzJESlJzY1dyZEhGRU9H?=
 =?utf-8?B?bkMrZElsZlFhbk1JZFlETzNRVXRpbFRQTnZ1ZUJCME9wejlYRVRDRDBPeE1r?=
 =?utf-8?B?eVZlSjZKb1VPejZKTGFubi9VdzJQck1YcGRyaVVLME45d3ZLSHVrSE8xUFND?=
 =?utf-8?B?ZE9vK3E4WFY1QTBYRmEwbkRpWlFIUk1IRUZlYmhKTytyZXcwYmdORkVSWDN0?=
 =?utf-8?B?Z0M0OEZITVBsczhYZ1lsYlNmTXgzdzBua25vMkphWUpMNGNhY0lWemZWc2pV?=
 =?utf-8?B?aDdubTdVWm1kTTRkNzREL3pnTnNqL3hyb0pYWjJZQUtLY3VNNE5qVXVjVmJn?=
 =?utf-8?B?VU9SdTAyVEJoQWk0UDdMZEgyNitZWlJmWFZPblkvZ3hXTFhLRjJKR0RCMVdJ?=
 =?utf-8?B?MW9sTU1ZeDJUZnFXWG1FZ3I4S05jMlJ0bTNsSUhacXNaTUxZUVYrd1Jtd3ln?=
 =?utf-8?B?WjRhcjI3NHhYME5xNFhMbXp6RGFLYzdEZnhJcm02NWFwOU5uMmpVSXFWVVZG?=
 =?utf-8?B?cGxuc1laVDVPVU9URWlYMWZ6YTNzdFA0d3BXTkxQZzY1MEFscDlWczRkNzRZ?=
 =?utf-8?B?YjYrYktjZ0xrZmdPeWV5YnV3K1IyL29zZnF2emMrRjJCODFrUklnZkd4RTYz?=
 =?utf-8?B?dXFOQktlTS8rQ2hlNURuU1BPSE8raGxMekt5c29hbEREbUdITzl2WlA1K1hx?=
 =?utf-8?B?RjVWV0dOYnNPanY3NkFRTkpCVngvaGQ2dERpeWlrVldWWlBnVHFpd2RUTUty?=
 =?utf-8?B?dWlVbFlYcDFmOW5JemJXWTNGQnJpNWxxUnp2eUNpUWx0VTVOZHAxUXVmTWQz?=
 =?utf-8?B?WEt2MkJPYVN0Q0drV3lZa3BtRFkrMUl4Vlk0N2FlbTNPODduN3l6Rk1zQ05l?=
 =?utf-8?B?OSt0bUY1V1IzaUZ1UjRyeTEvV3IxVFYzV2FGejRQUWtKU1JtVXo5SVoreEho?=
 =?utf-8?B?Tk15cUpYL1VKYlhOOVFOaGdCcXVteEcxWHFVMFpwTlZsUTE4SVJiaFZ2R1Aw?=
 =?utf-8?B?QzJqaFpHK0taZUQ5cW9iUHBlajZneGtzRldKcE94bVcrSVAycU1aU2RHeWRz?=
 =?utf-8?B?emNwSml3WlBPVTMyZ0xNSUtvSE5HUnJETVd3L3RmK08yMVphTENRTzltSjI0?=
 =?utf-8?B?Y1lFV2x0c1BucU1ibFpCWDA3V3VYZDNDZlh2eU9heXNQbkFwUHF6Yko3bnhn?=
 =?utf-8?B?Z3JKU2xzTnZXckFvcDUwYmxncXBKeS83YmpZaE9DRlo4ek9QVEhCYjNlNmlE?=
 =?utf-8?B?UjNMc2tuc2Jpem1DSnp5WjdnMUxsRXlMUVhBb2lTaGVrdGx0d241RnRtSW1z?=
 =?utf-8?B?eHJncUJVeUNINElWMWtNWlptczlBcTY0T21HRUM2eUVqc29aR0JKWDJ5RTNN?=
 =?utf-8?B?bGpuSFpNWkwwekhNMENXTFlSTUExbUFrTzBrQkFwQjNERFBDSThwKzBlZm5m?=
 =?utf-8?B?ZXNGUDAzQ3VESFBocjVtOGd5THZlZWgyNTQ0aDNMSFJaWmZKV0xjYVVoRWQ5?=
 =?utf-8?B?bWhrTy8xZytKay90VnVHRDFIT05jYlUxUTNGVlhQaUc2TGkyN1FkYWpSajRM?=
 =?utf-8?B?RkxlK0htbG1Nd3NjYkxuYkpoY3BSSHZUMTFZb0NaZ2s2TzRlL01DMWJmcTRP?=
 =?utf-8?B?Z1dzb2F2TmdEMmkwMGFqcGRuMll3NnVFbitXZ0RmTzR4YkZjRWFCUFFDWkxH?=
 =?utf-8?B?MFB6RUJ0U3lnVStNT0ZJSVZTa2Z3b1R4YkwzaXk3ZDhaQWJvVkk1amlCc3Vs?=
 =?utf-8?B?UTFlZUpTSDgzZHphS1RUN1BMK1FpaE5BTXFaY1hSMWd3V3gxVTA4eUVrK1RO?=
 =?utf-8?B?SCtFNjcxWmZmUExjclpxYlJLNzBwRXFiRHViK28zTXE0Z3hzMmpwQ0hmcUlo?=
 =?utf-8?B?Sm41OGh2MHBYR0ZGanlNT0gwckFrYTVVRGZjSi84bTRmb1NMMFRGMUZDY3VY?=
 =?utf-8?B?UjN0dFNWUDEzVWVGWC8yUXVlR0I2ZFI3cGdyemQreGRMVXZmWHdJb3l1dVBV?=
 =?utf-8?B?UGJpUGp1N0JvRW1WY2JLejlyOUN5RXpZSGNoak1sYjdjNG82d3AwUT09?=
X-Exchange-RoutingPolicyChecked:
	Sw4W0z+MDET6ioRfGEyc20GXxXZCrJ+Jl/dtdUY6W5xLpJ/NWMfcm58QzV598dhw4X4iEK62VZENJigSDH7WKopDb1sOLmIDtSXR2mMbeh9gGU5avP1nyMQ5jXVxQKlBwosTp27wEHQnQ4JqnZkbaGgLiWINUg3tIwaMp4pUN8dcCjRrJ8EwdHQ7+khSsyP6sWW0k2Rwn45miPulT30FRAYWCeuePB37MLOWyXVigeDaU0S7vOIh/ClmSdS851TzO76v2e0lKaiJIM/mgGygQ3RknTDXPB6rDktzZBlzMZdxToZzg4SGz9oXUASwBbmFA7pAtT8W42g/G9ZhsVV7LQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cYLG4mRLjqwOdUpEaI2Bx847+bHgjkbuP7P5MpL6Ck3bpx64adOLbrKTeRTIGV02W/H/uLbay4IU9g69ElXz/d9Wooq2f92nfBKAWI+H7xPwtw4PzmEHTm8aflIR/iCEwnfLGW1So8kRLygEJYI0NS3f2v5H2QeP+It9K0Mv2ySFTHR2hsmTW2xeZpl+Mo03g5B9oMao9zmp1WzHQ5pfrOxw8K6ipet22Z3bcUGo+Ut48lJH+TXKa5zhivxWmvf0crUdg85QPna1owGfOyVorjO2BdlpQWT1PikOJibnLvhqctFa7SquRiSHUe5EFWYOPpNqQtc7mBzQwTU5m0ZgQR2UWgGx/Yz5QMI4TQkySbO7GGnHQmh4AhJYqL+LW9RtXBQoJHuVY3G2ZW6C1PRMKOqwuvh7NvmhGE3xg4voyaqCZOiR8e7DzVfIupKx71ewTl+kSFH9oUY7r7KxAHAc//LaVuwPAXpWf++9Qhy55y60pVDOxG0Wx6LOmJiNG5/HstanX8HlOhSqthyfh58od2OmaOIBN7WtJ0QD0f5/yVvjbjmWrREnM6kMobAZE1XljrmZz5EqytvNpO4U8ttmfdYZ6i/DN8r1Vv+E6yG6+U6efI0VmQvW18l+bFsa0yb+
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: b74483ea-8231-40c3-8764-08deb2c28c49
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 20:42:58.1288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wXN6uBzjtz1kSUDid2gTH3/wgOeaJhHWVhkS9YnGEzcF/ty47jETrsChJLhVWrRP9Zxh0/0TLO1sucPr28XLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10435
X-Rspamd-Queue-Id: EF4FE557842
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[uwaterloo.ca,none];
	R_DKIM_ALLOW(-0.20)[uwaterloo.ca:s=ces1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288450-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[uwaterloo.ca:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkarsten@uwaterloo.ca,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uwaterloo.ca:mid,uwaterloo.ca:dkim]
X-Rspamd-Action: no action

On 2026-05-15 15:46, Martin Karsten wrote:
> Skip the extra call to napi->poll(), if the gro timer is armed at the
> end of busy polling. This removes the need for having a separate
> __busy_poll_stop() routine and its code is moved directly into the
> relevant places in busy_poll_stop(). Remove obsolete comment about
> ndo_busy_poll_stop().
> 
> This is a follow-up to commit 58e2330bd455 ("net: napi: Avoid gro timer
> misfiring at end of busypoll"), which has deferred arming the gro timer
> to the end of __busy_poll_stop() to eliminate a race condition between
> a short timer and long poll that could leave the queue stuck with
> interrupts disabled and no timer armed.

Please ignore this submission. My mail client decided at the last moment 
to replace empty lines with space characters and I didn't catch it. 
Truly sorry for the spam!

Best,
Martin

