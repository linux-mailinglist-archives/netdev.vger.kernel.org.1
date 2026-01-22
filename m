Return-Path: <netdev+bounces-252475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UI9DGRFocmmrjwAAu9opvQ
	(envelope-from <netdev+bounces-252475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:10:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEB36C0A2
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 551A5305EE93
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979C1F9F7A;
	Thu, 22 Jan 2026 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="p39gcVF8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3933542DE
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769103791; cv=fail; b=lPC4UVe6/Mn/IlMg9r995RM4YxVnRIfFjn854+Bf169al2fOqCSXayGqVedt4ibFngfNAwimuAMQU20ISmtMejz8aVyIz0Q4YuxfdLOLQHI8EU77q/wlDSqEGWz0womMGa2AUnJlFEzlHbl4+r4eT73Pl6IGYJ1adhoZXVc4hV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769103791; c=relaxed/simple;
	bh=s3or8nUsstmm0w1gr6HEeqi/p+Hll/yhWhnWFS8CeA0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Et5rqFjB3aC+tdrPmIzupxZIOhPkkj8rS8W5OAPxq2hJK0LcFllI6AmdpogTXy7VBpm+v+JJ3RxjQEFHv7e5/CUlaF6sieG5Zvn1YPC5p2bDZu2kqCt357/56E4XIsg+EkDLZo3hGEwV2n6Ai2HP6IBAjdU1sXv9PokIl4Q5E7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=p39gcVF8; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MGP2513853796;
	Thu, 22 Jan 2026 09:42:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=+K2yFDCBoB94oReZ2MdWcm6lQi1zS2S3JdSxC/qRj+8=; b=p39gcVF8sF9Y
	wxKpqb+EImrxnR3B2I8e2XjYl5Qw5gEDvJ9sSeBeQ6t4vw3MolTESDXK01NPyT5w
	DTCkUbVhe/n/gFPJEFmt0G+VZ4yQqCnS8inoDaL4rmOf06VsaMOinWBZ5IEXt/dS
	8fcVAApyR7+zmbONpil35pbPAXUbceqnlIXTJho0OpljuvC1yfkzEAzGS9fz6Sa6
	eOttooJfUVlqE/AyUmyXe9Su7/XLNzL8OVNuXx4jarb2eLM/IqZnBrZ6S/E04SLt
	7sWXwRMDjH9/025c6V9P/LAso5PdGJG6SdBRrbHWAy6/wWP5paWczvWAMrLHjtLO
	ZLTOyEpUpA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4buqd78vkp-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 09:42:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PD4/CrQZ+o8zwvjLdidj8QkJ5xOvo0andirBu0xMoeZ4R8sf/gJANjikqRZdHE9pJ2OGP1pn5lFmcUgFwmYgQfsngi54pbvmKLLsHUKmoQEeieuwrg6Du1DMr5vYW+ozDeJ/clPFOzo5ruoHr+H3tesqSxBmyrXE0kMKxs30zEsdtwZdk7jOYEuxlBkrP36KXi7tQwqrXQV2GcdWXdnkJfcuGHGccwbK4y/WA8h2c8s7N7tP3nastYxtPW65JQsKDSj6tLx99Tqy/Ro1GaBRbdxbN2CPlONFmMUsvx+5aG4sWbl6rdWBPgGsr7f6UkFa0fodM+Kr5ZVETLr7qkiTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+K2yFDCBoB94oReZ2MdWcm6lQi1zS2S3JdSxC/qRj+8=;
 b=sFDH062YQforh0+FDErhjOK4Gii6xfJIo3tHYWegcV/Dg0r3GjlJjddENG6CTKRPeCBAF6qUvOgLjirKhNDCJtdbRRdjP/XVgqEmYj0WU1QfwVujxyaTEv9JMlb7lX7ry9LctWl/pKbZUi2sKdA1F/VTPFFw/kiftRrSWMMDlbCrSVfKzQpf2BFlPPSqn7+WCoy8hhYs6xkAAq2yEZ1AqKRn708vKpHEHwRLqcbyGhNOEYtHF3ZTi5oq/Yd0FdnpiJQTSlJWrBNgTiY5JNb+A4qLoZRkfsPgKJAlpgogeGQacacEQUYvUvXqYPAW5vU/FNRjY6Az8CzQQhLdgXZMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH7PR15MB6463.namprd15.prod.outlook.com (2603:10b6:510:304::9)
 by PH0PR15MB5085.namprd15.prod.outlook.com (2603:10b6:510:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 17:42:45 +0000
Received: from PH7PR15MB6463.namprd15.prod.outlook.com
 ([fe80::46c0:7653:5dde:4b66]) by PH7PR15MB6463.namprd15.prod.outlook.com
 ([fe80::46c0:7653:5dde:4b66%7]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 17:42:45 +0000
Message-ID: <c7e1b0e6-c405-4dde-aeec-c1e4a95532be@meta.com>
Date: Thu, 22 Jan 2026 12:42:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [net] bonding: annotate data-races around slave->last_rx
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, syzkaller@googlegroups.com, andy@greyhouse.net,
        eric.dumazet@gmail.com, pabeni@redhat.com, j.vosburgh@gmail.com,
        davem@davemloft.net
References: <20260120152856.1694824-1-edumazet@google.com>
 <20260122022237.2529455-1-kuba@kernel.org>
 <CANn89iLK1saW=7jxhtew_skR-rPPonFi71brvTApeKM5VVadiA@mail.gmail.com>
 <20260122072858.2b652eb7@kernel.org>
 <CANn89i+0kJ5M1_6NPxbe4k5eY4sPwNeKN0yKyaHzFhZDT9-=kQ@mail.gmail.com>
 <CANn89i+7H32ODq3=nEfoORTR+6FiO2mOWRcLFf-K=+4UQcOmig@mail.gmail.com>
 <20260122085813.47f7c195@kernel.org>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20260122085813.47f7c195@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0013.namprd22.prod.outlook.com
 (2603:10b6:208:238::18) To PH7PR15MB6463.namprd15.prod.outlook.com
 (2603:10b6:510:304::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR15MB6463:EE_|PH0PR15MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f695b77-af33-4f3e-a9fa-08de59dda6c5
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Vks1NTBBRXJ3R1dzMjNQUjhhcldIa3liVkhqbU1tVHY1TTR5cXZhRHBRc2tF?=
 =?utf-8?B?RmkwWVRYbUZEUG5VYndJRVNMMWZnZ1U5YWkxZmg4SzZIL2xyOWRtQy9DYjAy?=
 =?utf-8?B?RGIyNUVJT3prQ2E5NS9xaEQ1dmE3aElMbXU1ZW5iS1lMbDBhbm11ODdVNjZi?=
 =?utf-8?B?RnRUa3NMUGI3SXFkKzY3VTFUMS80bWdFQUdqVGQzNzRObGQwcXcxVVR0NkMv?=
 =?utf-8?B?cURZREJtdUk2ejlpL0VIejlzem1kbm9CMmRGMjBkQTZQL0RWa0twYUQxNm1o?=
 =?utf-8?B?c2FCVHZDRHFMa2haOXdGaXFzUjdjMGQ0R3hGUFo0Slh4MXd6SnhTU3hya1Np?=
 =?utf-8?B?V2k2Z3pBSWdsUms5UlQ2ZjJVZGVkL2JWTm9FZGNNakRRQjFmb1RPQ3lwaVlE?=
 =?utf-8?B?MUhnWU81ZnprRmh5dWJTUllUaGF5TFlxdlpYVUVubGM5QWFJZjZ5NUh6a0Z1?=
 =?utf-8?B?b0FuRFhRYXdneFQrcitLWXk0WTFpNW14TTJyTmhKN0p0Mm41eVJnNVJCelhF?=
 =?utf-8?B?T2tDaUp2Ny9VbGNqblRCSE10S0pIK2IxSzFwVXorSTNnRlFLWGhNV2xMRGZG?=
 =?utf-8?B?cHRmRFNRb1VJay84KzZFK29ZdkFHbHpSWW9wQk45alQ3SWZwbUZZaTJxMkdL?=
 =?utf-8?B?UzZoTkhaUW42VDBjbENVL2swTEVvbUJvaThic0I2YjhyRm9Nc01wZVJ1RXJZ?=
 =?utf-8?B?Q2YxbHFiWGxFVVpnbWRWOUNBT29hWnUrb3B5clF5eXZsc1NXb2gyYUNBWXl3?=
 =?utf-8?B?Mk1yVzFVaUp0R3pOT0E4QnZwMjhyTXZOS3A5dlFpRGYvVHdRcTkrM2ZaZWcx?=
 =?utf-8?B?UEJaU25YRHUzTWpORUZ1RHNQQU9QZEp5bmtvY1k4Z0lqTDJXMGxJMWk1Zktk?=
 =?utf-8?B?QmJ4MGJEd1BGeDRHTmlacTU4Tjd2TVBqcUVKdHFVWTNDdzBlWDJDaUdpMlVF?=
 =?utf-8?B?RjNZNmE2cFdLaUhBWktjRGhiZjR5elZGdDNjdHZqV01lZkZXYmt2YmZNc3o3?=
 =?utf-8?B?bmZ2MStqaHorV0lRZUlpVnVST09sTS8wcElmWUFGWHJTR1o3RUxxcVlhZlh6?=
 =?utf-8?B?OGwwWXA3NUU0bDd3c0lFaFRLTHdKNlNjdjc4Q3lac2ZvUnQxWExmU0pIWnBN?=
 =?utf-8?B?d084TU9GOXlyM3JORFloeGpDWWZUV1ZmbnYybFNmM1V4MlFEa0dLYVlFMWc5?=
 =?utf-8?B?blg3SDh3VWtxemx5UzFUa040YjJNTndzMTFzblgyWWR4and2ZVQwN0kyWGls?=
 =?utf-8?B?bGNKVHdzUllWbDE2RlBZYnJtTVdVU1MxVW1CbGcxYlFhcE9iblc5M0gvakp2?=
 =?utf-8?B?bTdldjZOOENlSGFydytjNkJTYW8zQkhhdXp1dDdtU2dsRWNpV2JPdi9NWnUv?=
 =?utf-8?B?WmlUV3NicEkzdGthVDJiWCt2MVdUTGJORW9tMXNscmR4dTNlcURFNDAzWWJ0?=
 =?utf-8?B?ZVY4dTV5cHh6SlkxemZsdTFaVFd6NlAzczBNdTNNVjNVYWhNdTQxdHJjMU1k?=
 =?utf-8?B?enYxS09rQTU1WVlZTTFkQ0c2NEFzVE8xNmQ0UVRMRHVKRDJlREc5Z2R4ejFW?=
 =?utf-8?B?N2dyYVJRN01LRklXWlBlekdBSjFKeHlVTytsd0RneTk4VThUcFVRMGgybzBq?=
 =?utf-8?B?NHRVdkhTRWZzUnJydE1EYWFRYnZid3cxTUJ0ek9wcEJhR1JqdWpVVHNQa0dE?=
 =?utf-8?B?UlluUTloaEFZR0FuWW0vcHhCYUlXNnlmc0l3QmxuY1htb2lQUzVSWEl3SXVm?=
 =?utf-8?B?alFIYnJzWVZEVEZKMGtqbDMrdjh0bHRxM0xNZE1xOHRPRzRUd2RkcHRVOEh5?=
 =?utf-8?B?S2F6aUI3bGZTNjBNTmdBS0I5WnZQSHVGS1NGQ3ErRkpjcU56U3l0WkpwVkx3?=
 =?utf-8?B?S1ZlZFd6R0JkZXp1Z21Bc1BIU0JhQ3dmcnVrVHZlNElVZXlvVW81TWhVdm9X?=
 =?utf-8?B?bGdqNlF2bUduWG5kS05QMWxQY2FnVU1wNlMwcUdIV1BOU1RUVjkrQmdDKy9O?=
 =?utf-8?B?RFJJcnRIQmV3YktzOWVTTDNxSXp1NnYxazVKNlN4TVdDUVBldjlPNm5OckR2?=
 =?utf-8?B?RlB1eW8yaUdndGFJUjl5OUVnZTlzZ0lyTVY0RVVINFdBYzlJNGZCcDUyRzB6?=
 =?utf-8?Q?LPvA=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR15MB6463.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZTd5RWlubHNZdFZhVHBHTVpXUzMwaW9rSS8vNUJPaldiMXZSVjdOZmVzY0ZR?=
 =?utf-8?B?R1g2TnNyc2F5Uml5a1h3UndhTUIyTjViaURIa1JoSFV4WmJqSkM2aFRDMGZ0?=
 =?utf-8?B?MXBKcy83WHViU1JRUHZxSHV2dXBERXRXNm9IVzA2TXdJWDhBQldKdlJkc2R3?=
 =?utf-8?B?QURNRlpRS0t5b2FPQWNZeVZFRVFuby9YQ20wREFsRTBOeWFSU0xPVFYzVTUx?=
 =?utf-8?B?VXhkMWllYjhmZWR0MzZJR09ubENMS0w1OTZmQ2tjWGVNSXZWOEtxN1dvMjMr?=
 =?utf-8?B?V1pKMGJ1K1NVWjBwNkdIQkgyNDIwc3R2R2srVkl1c3VYTEgyeWVudEpvQ29M?=
 =?utf-8?B?UElMVTNiTXYzVXdUMGFEeEh2eFJSZyt0YXpwdUtLVFkyQ3RFU01OckNLSDlL?=
 =?utf-8?B?Um5wSGJWdDRzaUtLbkRUNXowRnpyNnBhMUdjckJRWGljNVk4VEZKZ1pOc0w1?=
 =?utf-8?B?amRKYnp2TnlIZXFJL3lZZWJUZjBIbDdjaEpGR2c3RlZBM1Y4SEZQUTFsSGo0?=
 =?utf-8?B?akxSNUJhREp0cFFYL0NiZHZzTU9EU1VTQ2hFQmpPUllRTWhlSFJ2b01FeE1W?=
 =?utf-8?B?K0Fza0JLbms1VGdFTEl3bzB4dW1mMXhPMWtvbG4vNEJDUCtKVGNTTkU3d0VB?=
 =?utf-8?B?WTZCYkdDUzJxWFB3NkdKdHBWeHlvZ2VQVy9xUm43VmRUenpUTEVFU3FoKzRT?=
 =?utf-8?B?bzNOSC8zWEpjUUt2VEVoWjR4NDdZTUZHazFpREQyM0c1RCtxOXBWVVk4SjBx?=
 =?utf-8?B?dXVkZzZOTHdpdWVIcHBvdnplbjlwM0JtS2MybitTb1JINUpWRWpmVWxHVmhL?=
 =?utf-8?B?bHdQUVdBOVlIUUVMNEZrRkR1TmxydlZwQ1FVYkhjVjFUZi80SUlXdlBsVkVV?=
 =?utf-8?B?ekQ0YlVrYnh2ZGFPSlNsTG1FaDFZUWFoY2dFbjAyZHVTamJidm1ScU9vYTB2?=
 =?utf-8?B?NTFoQTlVZVZ1OGc3T09xbEFLNXFuWTQ5c0xyTHZPSUlFd2VPaVpQODRYZXA2?=
 =?utf-8?B?T3NzQXUwZFlXbjZ2UEpPREFIZWVXNmpIOTFzMlpyaUtqb2I3eTNrWU5LcG9m?=
 =?utf-8?B?MlIwM2huazhoMGl4ZDNUMGtoQVhpNnRWakkyL0x1eThKYndqelhzbWE2dFdI?=
 =?utf-8?B?ckZBZGtDNjBPa2lpeGZoQzhiTGhIblFaRndlL2pjeWdvZ3YvRlJxOGQ0cGk1?=
 =?utf-8?B?R2N2a1JFWGtUb2R6aXJmMkRVcHp2ckRDVVNPMGdTZENYUUlWZ0ZpWVJzZ2la?=
 =?utf-8?B?UDVybWZsQ1FsV3BkWWpJVGprcmd0blJyMUVINzhOMkI3c1FqRVd0dlBWaUh1?=
 =?utf-8?B?SituWjFuclJIOEh1M3NWZW1xZEVaQ3F5RGdYTnpsZlpRaUlGRGVVMUVvZE1i?=
 =?utf-8?B?R0R2cVhxWHFabVZ3N25rYUlXWU5tZXg2UnhBNVY0c0tJb2lOTmM5ZXRpQ1FK?=
 =?utf-8?B?bEo2RUsrQjZFbHhaOG5HbUd0Mm1vS1BacXhwdWcxc2hoMHJRVXFzSkloaVlt?=
 =?utf-8?B?L0pRMkVvVDFLdXF5b3lDMEtjSnhwWU03bEdVeWJqb0pZRW11MUw3cFJVSzRv?=
 =?utf-8?B?T21BODRLVndSb2psbit6WXd0TTBRdGhkSHU4N2NlUkdneTdLbDRoUDRiYURs?=
 =?utf-8?B?V3FjSkk1NGRscThKQ1ZqcG4xQjNVVEZTMlRNdG5rTXN3aGh2RFAvRXJoVjVP?=
 =?utf-8?B?QlFBRlRYUnRNeGNFRk9aTDBGVjg2THpRa0VIRUVWeUZCV2w1M2I3b3NFa0tt?=
 =?utf-8?B?Yk9remtQVmFkVEVHTURHTFpMak1nMXdCWmtkRndvTXdWdWFOd2R0aVZJOE1k?=
 =?utf-8?B?MXpmN3hkdWI0R1cwVTBQeExJbnM5eGJmclFzT2Y2bXV2WXplbjZlYWZxR2oy?=
 =?utf-8?B?Ykxzb08zaGtnRU5FUVVDVllFNmZ1ZFEvK2JMQ1Jtb0xjUllKbmc5YjRGdkxL?=
 =?utf-8?B?aTUzdVlBQVkxQTQ3bGpnWkNKSzVHQkxGQTRySEI4Y0dyb3MyM0d2cUhoNzBy?=
 =?utf-8?B?bFdjK2dFT1lRbVNqcVhERWlDakdVUStETGkrVG1VNDV2bGVwUEptaDZSamdK?=
 =?utf-8?B?N2JNbjlIcldIQ1prZ3RMd2oxL290aVpHZTdyN21kQk1mZkc0ZnZYaDlJSU5i?=
 =?utf-8?B?ZDMvM0xnVEVqemd4d0o3RUtWTkwwWFFtMllsWUwyak5tTE4xaHJmSG9BVk5R?=
 =?utf-8?B?QitkSWJhQ0szSlcvMWFick1IUGUxNUZBS3lEZHRYN1B0TjRGREtBalFBckhW?=
 =?utf-8?B?dGpQMmMxZXlLckdKeEpEczFlSDJIUTFPb0RBZG4xSTluZzlGQm5xdW92a0pw?=
 =?utf-8?Q?wBEaglvTO+nGPyf5bm?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f695b77-af33-4f3e-a9fa-08de59dda6c5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR15MB6463.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 17:42:45.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86LmzkIHEb9xXZIZHM86+BY6vf6DYe/k2MEWc2PzzjVDtEggD6KPPFYOaKl/BwTX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEzNCBTYWx0ZWRfX/496xRB7ZLvA
 ApDp6eObquAIGuww8qyJjseBwdmf8zJilZtH71Mf60VWi1uriDZC2AMfN8+Gbl23k6sJH84nN8c
 JHS8XGsZFE7rXE6r2lU/Z/uC/aM9yPoSTLoXZrSGc5rqtpBponKJQKvMhkLaYmyPX+AIjSU6KnD
 QWn1t6bK/+Qmaj8bAiDdDPAtWrSSYq8JJtWMeoPHk9ovD+5ebmdAQskQbXwjdav+wqzpOT2Ni62
 t+5NH0yS6KmCJZOt1Bbi7JsjMcSGAnkgQWzTEFOeszH3ZWdXmSpC2LORSCA0+ZC7ff1AEBNs77X
 vXfU1BL12cg2d3HKcdNgWv+nKCbYx3JBnP6BF/RV14NceGWpxuJFFtyw3nCVrxelce36lfuXR/J
 lzIbl9w8Za5PQUQRs4kiUJmVtMNRChcPcOZsuUCPNLl8RucO+k7EzkJeOKUq4g2MkURVUacg8ev
 rGkKDiMgIe5MCnZtZ8A==
X-Authority-Analysis: v=2.4 cv=NKrYOk6g c=1 sm=1 tr=0 ts=69726198 cx=c_pps
 a=bMdnqNz3r98bn56uXvEeDQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=pkgNt-qU6UynUwr4Z9sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Wu-MEq99WreMD_xBQnTO1t0Sq8oArIcZ
X-Proofpoint-GUID: Wu-MEq99WreMD_xBQnTO1t0Sq8oArIcZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_03,2026-01-22_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,greyhouse.net,gmail.com,redhat.com,davemloft.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252475-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BCEB36C0A2
X-Rspamd-Action: no action



On 1/22/26 11:58 AM, Jakub Kicinski wrote:
> On Thu, 22 Jan 2026 16:56:33 +0100 Eric Dumazet wrote:
>> On Thu, Jan 22, 2026 at 4:50 PM Eric Dumazet <edumazet@google.com> wrote:
>>> On Thu, Jan 22, 2026 at 4:29 PM Jakub Kicinski <kuba@kernel.org> wrote:  
>>>> I guess if nothing else we should do it for consistency?  
>>>
>>> To be clear, I will cook a V2 with this part.
>>>  
>>
>> _bond_options_ns_ip6_target_set() probably needs a fix as well.
>>
>> Is AI review stopping at the first error ?
> 
> I don't think it explicitly stops after the first occurrence but it
> seems to have limited ability to dig around. Simplifying, it only digs
> around for 5-10min, and it spends a lot of time proving that the
> issue is real. So once it's spend time proving one issue it's often out
> of time, and may not search for another one :(
> 
> Ccing Chris, hopefully he'll chime in later if I'm wrong.

It's supposed to keep hunting for bugs until it has reviewed the entire
thing, and then run all the bugs it found through the false positive pass.

But, sometimes it gets really excited and jumps out early, or as Jakub
mentions sometimes the context window fills and it starts skipping
steps.  I've tried different ways to force things, but unfortunately
none of them have worked 100% of the time.

-chris

