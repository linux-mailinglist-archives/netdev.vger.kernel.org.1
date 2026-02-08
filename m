Return-Path: <netdev+bounces-257825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OzyyGymRiGmirQQAu9opvQ
	(envelope-from <netdev+bounces-257825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 14:35:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A38BB108C66
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 14:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68488300A4F0
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 13:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE35F288530;
	Sun,  8 Feb 2026 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FwgHNjDB"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088727F4F5;
	Sun,  8 Feb 2026 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770557732; cv=fail; b=K063LysEgbcT6q6F/1MO6VwyLYCd02h4dj//KpgKolT9Abv2aSiiWs0fMDBuUKzsLdXJJx4eYJ2xciHhrcgfDgp8AxV4UIkUDwLGhv5M1YXaeN/dhglphRaIb72Nth+HYO8U5Ah6VqqFFhJQQsdu/E40ycsqbg+omolv/NXLouQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770557732; c=relaxed/simple;
	bh=kSR4tJ91PHE/sCV+f2BRSkip12rwlHiLqodRX3QV2KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GZoGgkHSa2lH42k0EPUrtfRjNSEfj/452NDSjruiv47gdH7ka7xe5aZG4fmeaz216/xBHt3ESIheV/a9tNuBcZODSUqbT2lzB/nWbIMorBxNJ/MxYwdPW0/DEXavTiMBa43kihR7LtxenN/k4wewV4EpyfqEVG+xZ89wV8q4gQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FwgHNjDB; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZPIjxh4iWGYWBtKfwkOd+3N9q//r5Zo77vxe/8EVEUBTWR/aikW4DoKYz18MH/NSBYG5ILKRl/1UtvUcI0PmjRrbro2xvL+EK/jWOI09lvjlnlQPTfT/66RDme10fBoHHt5adaAmevHdd/6/0rST1x4RzNARqYdaB47fbbmf+eIJvPLEIg5SQeIrRr+0c1U2zlWYMt9EiHYK+GjMnHjcX1lhSVeBS2T7iWrwvpJYqFDI+kMXyf2XHSGEiI/dswyAcyzIritWFaqxHUeOvxDS3dC5VGkiXEfcO0viEgNXyOCD6AhiOvW8sYqDThAlkRFZMbr43hRGRLGt/1T+FpPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXjusbykNFjtMyljvYi2INziJ4cM14za9cmDPiGKMvk=;
 b=g7TJaaiPpTs0BeeFXmOswVOG3GQEUu2pcYAZZ0YVysiD5jNn6gbxB455fhElVYsgbOpZTFbPimwE1B5e3FoeBkMHX7xu5fwzwFOleR7OuSY77If8XZ0vENy1LSv4HqmBXQxhzJQpI79/6jW5XJF6p8ROoBLPqJLFMKI/x6/pQVfhT7IWEuglcNLC6ldzWZEyd93+7SwIPX9jdB7Pg+7OqHzYQap4+peMflrr7upmd+4dktV+nIZTjQx3vVWrud7ZckYYobS4Dy/vmO72iQK81LYdRjvBAoI/8h2W0d74vopvDXfna2ZErpZO2t8hwOso2dR6cXCK6NEPJaQgmlT7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXjusbykNFjtMyljvYi2INziJ4cM14za9cmDPiGKMvk=;
 b=FwgHNjDBCiIUp++PF9oTsfcFkvUkcvMaxtFqSX9NLimMUAbwPf70P1kWgFEt85vgdweIbQfSNc4xlU3B2uaJ6MTo8G+stZ1a0IERz9X/aFxolWX0jQrh87P6nKLDN1y8lXRGdWZnD04nQ7/JztNuJldFo92/UeN44VmBAPy9q/fyAr6c8J5y6Rd9xzDXssOK820phuxJGefmWkdNiRjQAAUlsmPYO0Ptg7DTbY77C0WFTlG7cfU9B6j5gZG6f6anCX/O9R6z+AejLIJX0DUa+VkCe6KxJJx9oA3OEpyE2S6Zz0HfTUIbL5lJTgHWxc1Xa1KSut2UvXFKltUQzxt3pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB7668.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 13:35:29 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9587.010; Sun, 8 Feb 2026
 13:35:29 +0000
Date: Sun, 8 Feb 2026 15:35:26 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: mscc: ocelot: add missing lock protection in
 ocelot_port_xmit()
Message-ID: <20260208133526.3ed3qzyyj567ylah@skbuf>
References: <20260131044911.2257072-1-n7l8m4@u.northwestern.edu>
 <cc23a37e-3b12-4dd5-89a9-ed8977601379@redhat.com>
 <CAMFT1=Y=FbjyqC6vr6fV74t8AmGVcecKw+YjX6V_iA7XgZtotA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMFT1=Y=FbjyqC6vr6fV74t8AmGVcecKw+YjX6V_iA7XgZtotA@mail.gmail.com>
X-ClientProxiedBy: VI1PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:803:1::18) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ffe581-bb71-4441-449c-08de6716ecc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHJlbzBwb2RIT2dkNjBIaGVNOWl4REY2clk2UFEvNy9SRkJHVmtYM0EzMmhx?=
 =?utf-8?B?VlZxMXZLS29tcWlmWGdJb1crdWhDZ3dkRTdHaCtobllGbjBWY0dtN0VEMkRB?=
 =?utf-8?B?TklPMEFwNzI4bWhZNUk3V2RGeGRZS095ekVodEJ6Tkc4WktIUWVMM3JlcnFn?=
 =?utf-8?B?TEV5Y1F0RGVSVzF0SngwdU43ZC9lVVNXM3FmbDI2MjdXb0RGYkEzckZBWDU2?=
 =?utf-8?B?WlN6TTk5UVFvNWFOYjhNc0FGSzBMcWdtZjB4R05Eb0Rkc2ZTZEsweUhsTW1O?=
 =?utf-8?B?RFpDaTJOejM1VTBhM1hFeGJYQjNsQTJoMHVBU1ovelBQZlpsend4Z0E5QzVl?=
 =?utf-8?B?ZmRyNVRJa001SU1hWlJXeldTUGk3WFVXVndQVXJMdVE2Z3p4ckxuUlRHQTJv?=
 =?utf-8?B?RTNtZEJ6QkRSa0YySmp6NERScXQwM05IaDhXOTd2MkZKVXJ1UzNpd1hvWTEv?=
 =?utf-8?B?Z0ZERmoxQlc2SFQwZWdTeDdrZmZIdndDd2U3SEQ0b0dvcVl4Z3liZmhjREZk?=
 =?utf-8?B?WW5tY0d2TXpXTDFkWEFrcUJMZER6dGdCVEtkenBTR3RxdGErditQRHpxRkVN?=
 =?utf-8?B?cmZmbVJ1OExqOUtDWWpRTE5NTThLbStqNWltMmFGazRDRWNaN0NPaVBma2Rs?=
 =?utf-8?B?TE1ZeHpockdHQUVaZTNlSWRTMjBtbU9MTGdkTW9UOEJBV0JwQm9Yd3J5bzBt?=
 =?utf-8?B?Q1lTNEtXZFA4RUw5VEpLSW9oT3JhQjEwdytHTjcxWnQwN04xSk1mUWh0UkdE?=
 =?utf-8?B?ajZlQVdDQkdkdGs3aHpXZDF0VlQ0L29pYWhsRUtCY0ZEM1dnUDl4cUxTNktW?=
 =?utf-8?B?OVY3d3VLVUZ5dGlyeTd2ck1rT2t0RWRSSUFJbjNoOERGVFlVVjlReU5yd0hr?=
 =?utf-8?B?OWMyTEIvZkJmTUNRRG9lNnBtOGpraGVzU0tDdEF2bndpZGtyY0dpRnVpWDY5?=
 =?utf-8?B?dWdLbjJDNGdwNEhFcHMxSGEvWU1vU3ByaElSVEUvQ2pZTHI4VVpRMit1ODFX?=
 =?utf-8?B?WFQwczFXSXFxNWdPRm5QZGRTNWlJWDJwblFIK3VIOHVsSmNXMWRPbVJPSjZI?=
 =?utf-8?B?Ui9zOEpLbkpOTE9SWVo5eDlMRmNjUkNKbzRsRDM2aVBWYkhzTkE5WnlySDMr?=
 =?utf-8?B?Y0E1K3dhQS92TnByaFlhZFFyR2F0cGJjaGlpUEhGUkhxOVdwdno5Z1M3RWZG?=
 =?utf-8?B?R0dLV3VLMGEvWW1tRTV2WXQrVmlITTVQTVFnZGkxdXUwd0dBcmQ0cXlpRGtN?=
 =?utf-8?B?SnBMWmdTZCtIZlBwZ3gvbHZMcVVkM2llZGtoS1VtZGkzSHZZRHh1MTR2RXhT?=
 =?utf-8?B?R1N6Y2NTTGsvQmErTnAvSHBvMVAyTEU3RXZ6RS9oNitWazFSU3RGSkFHRE91?=
 =?utf-8?B?TnY3SzA5WFIzNnhjY0FUSVRteFhFVmdQdGZsb0lpV2VsWEF6UHNXWlQ1dVZQ?=
 =?utf-8?B?Wm0walBJRE8wRVBDOUZxTHNXTkdQb1F3c2JoU2Q0OHkxc25ZRkJsRWhCRDdD?=
 =?utf-8?B?cDdIWDc0REIybndFK1o0UUJISWFIRkFsQU1iMWJtSm9TaU92a2E0Tm9ZRm1z?=
 =?utf-8?B?V3RVVWh3anFUbkpqSWlRY2VnSUc3dVJkVmVLMTBhRVZWUjdqUXQ0dEdEdHB6?=
 =?utf-8?B?TmFiRmhMeFJkSm1qLzE0YW5MK1hTVTA2bDJvMm9kVlVpREh0c1lzN3JTcit3?=
 =?utf-8?B?ZzE1bERReWRwdW1xY1JicWozT0ZxUjhSTkQ2OEFoaXh6a1RqUVF2cXZHQ0tu?=
 =?utf-8?B?TmRGbHdHQndGb2tiYmhVUStYNTZWbXJPK2l0MHhHVWo4OEFpczR2azBUaFBK?=
 =?utf-8?B?dlFlbEZiVGthbi9oTzdoUkhpRytZWXlXcVBZT0VJSGxxMFlKbVRvS2dtTE9t?=
 =?utf-8?B?YnluK0FxcUZLQlhHd2FTUXNWQ2lSNHl1eDFVR21HZmdzOUQ3Nnd3ZFFXZUtT?=
 =?utf-8?B?NmRqQTFOQ2cxTldWUnlrY1NEV0ZybVMyRGNDWHVOdlQ2K09ySXVLWVVEWDVO?=
 =?utf-8?B?OE9ubFByMUtqQmVnVEZKUXF5bmN0dk5uNTc4M29xbTkwZ2ZMeGZReGxSQ0c4?=
 =?utf-8?B?SUFkTnFva1QxWHRDWDRiQmJ3MkNTVVBITW84SWxQcW96R09SZE9yL2tJa2d1?=
 =?utf-8?Q?LJsI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wnp3OHN3bnpMR1hvVzI3dE0wdVN3eU1IdXluTEtBZVJlOTBpNjlvenVaOTJI?=
 =?utf-8?B?cEtqajJiS284aDlXamtOQUpXT0k1WDdXWEVOeU9zaEJVQ3E0OWQxSXRsTDBs?=
 =?utf-8?B?bkdOT0NHQlVKVzB5NERXdnR5SnNXY0M3bnZMeE9tY01VZEJPODQrREhEV1dS?=
 =?utf-8?B?dTZBc3hWa0FqT3VxRGtxMkxNTWVHMFZ6NjNqMmcvcTcxQnJSVCs0UE1LY2cz?=
 =?utf-8?B?TWR0SFhQQ1N2N3NaQ0FoeS9zbVNkckpReFlTVmJjNHlkOTh6VElicVBYQ3lv?=
 =?utf-8?B?TkxjbURaNk1wOElqMC9tT1dOWFRZUjhZK3NSSzV5Y01oNHplQS83aHVhVUMz?=
 =?utf-8?B?U0VuMjNGd3Z4bG5aenFvWmh3QWtHeXpiRjRlZDNUZkRQQUdYbUo4VWxQcXpj?=
 =?utf-8?B?MHV0K0pPd1ZpZWJvQ0hzdjNocGZWWkVhUS9vN1VEM0lraHV6bkFhbnd2M01V?=
 =?utf-8?B?WjZDSk5KbkdYQW1paHlyM3MxVVVYM05hYWxiazA2Z0lXTUh6c0QwYllFODBr?=
 =?utf-8?B?WjA2dWpaTUUvYnVkQWNPSGR4QmdBM3FCSEtqZXR0YVJHMkZHVFlmSE95a0dv?=
 =?utf-8?B?WGNpZ1A0MGU3WjlQZGFmNmgwb21xc1h3b2NwNkR3NytRdjFkSmRTZVd5RzV2?=
 =?utf-8?B?b3RXQXk2K3hac08vY1VmTlhwOHNQbitCbSs3eW9qQ0JsWDloMjh2R3Vlb0hI?=
 =?utf-8?B?M3ZnazBFUC9wOWpIZm15bzZPMldpZHd0NEFzQWplVkdsTTJxVkhaQ0hxa3g1?=
 =?utf-8?B?V1lYbkFobnRGWDdOME1UMDl0dTlrRTU3VXVrMDlFQUpCQ3pyZ056Mlc0dElV?=
 =?utf-8?B?aGFVUDFVb3dWV29CQUxaRVladUEwZC81b29ldmFRVnZEMGRzVmN4NVZLenFY?=
 =?utf-8?B?LzdxV1pXRzNKNDN2RHhQOFlFS3lPM3NnazNGY3FINnlqOUloNHZHUUk4ODlP?=
 =?utf-8?B?RmcrbHJUZStoaGpnZEp6bzZUYkk2TGZINGwvSmVOSzZKYklUTlhlcGZxY3A0?=
 =?utf-8?B?ZFlGUjZsbUtEM0VxZ3BNUGFwejMrcEpBUHRMWk5PYWdGbUE1M01iVkJaVnMy?=
 =?utf-8?B?ZjlPNjZjUlcydUNkV2dQdExpc3NtNHdvUnI5bFU4U3c5ZFNyWW5rWU1uY1ZC?=
 =?utf-8?B?dkdSY3kvNWF5L2ZieXJPSXp4Rm9saGJ6MzFCQkZvUzVIcHExeUtxUDJLNGhT?=
 =?utf-8?B?RDgyU0gvdVp6T215ekhOZ3BoSm1pam8yUjNKMjZTZ1pVMUsreVFzcjZ6Y0RY?=
 =?utf-8?B?bjZOOTgycjVxVzRCMEIzNGFVQTRNMU0xMENDVklnS0pmMm8xa0lRUkphS0dS?=
 =?utf-8?B?QzJGZE00MnNBMmZBblo1TGdCVzRyM3JTRVhVbXNYQmJGMVNLeU1NbXJtWEho?=
 =?utf-8?B?ajZSeHJXY3dPMEpPcTFLU2xIUHZFSjZ2dGRMRkI1QnNtTDdsUlBIZ091c2VP?=
 =?utf-8?B?ejJHVUtVTERiM3EzQncyMjh1TThETlE4VXdSN3djY2hHc1ZFUlZFL2o3Y3dF?=
 =?utf-8?B?bXAzK3ZtUXpMb1BKUFYyZCtMbTZmU3hzekRyVEZ0aVN1TFIzYUthV3p5YjlN?=
 =?utf-8?B?SkQ4TDl6bkJCcSt5blFhMzh5SnN0amxpRitjcjBkNXM5cldkS1NYUE1pZHZD?=
 =?utf-8?B?SkZDMWRJeGI0bTZDcndmVFc3SjFjcEdycWx4bHJSOFlSYm9YZXlPQmp4TGp1?=
 =?utf-8?B?T1kzVTFvbXJ0UFZrMlFJSVFHMXU0L1MySjBIL2RNOGI3YTJhOHZKc21VWWVq?=
 =?utf-8?B?Q21YV0pJMHR6MHlURkphMzFrQ0Q0ZUxUQ25xaldxZnNtTno0VnBtRkZDbzVR?=
 =?utf-8?B?VVNsangvT2pPeU96SG84Z1p5NDkvSGh5UDM3eHVtYlNDRjkzWmxIK1ZxNjk3?=
 =?utf-8?B?eWpxTXhsWGlFQ3Jabnk5Mmc2OGRqYXdNTFNjV24wL2xwVm9ZemRQN3BkMnMx?=
 =?utf-8?B?S1BzbkgvSFdmSW83ZXVVQ1kzWHVMcXluUGUyM2VFVlFmdG50NW5DbmZyNnV6?=
 =?utf-8?B?ZUtldThJTUExV3JhcXl3S3NSMGgzYytWOVFWUmFjeitEOEI3a3VmQW5JVGpJ?=
 =?utf-8?B?TExya29pTEdUSDJKS0djdXhuU2ZtMFRSTkd6ODFoR1ViQkhLcWJONW5NUmxL?=
 =?utf-8?B?RVdMN2dEVHJEWi9zVVdRTFErMUpyTlNPSDJuZWw5SkNxZW1HWCtLRHNsdkVI?=
 =?utf-8?B?MDJhTWtyOGQ5NXFKUlltd0JGcmhXZVk1YXhGcTcwSUV2K0xmUUZIMWhacHpY?=
 =?utf-8?B?YWlLUWd5NVgyQ0JJSmFGLytpVy9ZSzNNRWJvdFRGOXQyMWVyN1JRTjFndkQ2?=
 =?utf-8?B?cXRWS1prUnJQT0dEZ1psNCsvUHRpd1N0OXo1TkE3bkNCczM2MGJjUi81Skov?=
 =?utf-8?Q?GOEgECg5cz/TTn4mAXicEem656ZBJ8F+ogXEmiY7Dcu5v?=
X-MS-Exchange-AntiSpam-MessageData-1: ZH6U3becQwZnqSiSzs16Dae3v6c3amCAhQo=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ffe581-bb71-4441-449c-08de6716ecc2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 13:35:29.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQwukpAxQbtZTnU97eoydltsKHNGlbq03tnp3YOS3fWraIPx+S0xE9Xsb/7i3nxiHwNuIPC+A7Xq2C9bPDeXtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7668
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257825-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.955];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A38BB108C66
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:49:49PM -0600, Ziyi Guo wrote:
> On Tue, Feb 3, 2026 at 5:41â€¯AM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > I'm under the impression this static_branch_unlikely() usage is racy,
> > i.e. on CONFIG_PREEMPT kernel execution could enter this branch but not
> > the paired lock.
> >
> > What about moving the 'Check timestamp' block in a separate helper and
> > use a single static_branch_unlikely() branch? something alike the
> > following, completely untested and unfinished:
> >
> >         if (!static_branch_unlikely(&ocelot_fdma_enabled)) {
> >                 int ret = NETDEV_TX_OK;
> >
> >                 ocelot_lock_inj_grp(ocelot, 0);
> >
> >                 if (!ocelot_can_inject(ocelot, 0)) {
> >                         ret = NETDEV_TX_BUSY;
> >                         goto unlock;
> >                 }
> >
> >                 if (!ocelot_timestamp_check())
> >                         goto unlock;
> >
> >
> >                 ocelot_port_inject_frame(ocelot, port, 0, rew_op, skb);
> >                 consume_skb(skb);
> > unlock:
> >                 ocelot_unlock_inj_grp(ocelot, 0);
> >                 return ret;
> >         }
> >
> >         if (!ocelot_timestamp_check())
> >                 return NETDEV_TX_OK;
> >         ocelot_fdma_inject_frame(ocelot, port, rew_op, skb, dev);
> >         return NETDEV_TX_OK;
> >
> > Well, after scratching the above, I noted it would probably better to
> > invert the two branches...
> 
> 
> Hi Paolo,
> 
> Thank you very much for your review and comments!
> 
> How about we use a new separate helper function like this for previous
> 'Check timestamp' block:
> 
> ```
>   static bool ocelot_xmit_timestamp(struct ocelot *ocelot, int port,
>                                    struct sk_buff *skb, u32 *rew_op)
>   {
>         if (ocelot->ptp && (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
>                 struct sk_buff *clone = NULL;
> 
>                 if (ocelot_port_txtstamp_request(ocelot, port, skb, &clone)) {
>                         kfree_skb(skb);
>                         return false;
>                 }
> 
>                 if (clone)
>                         OCELOT_SKB_CB(skb)->clone = clone;
> 
>                 *rew_op = ocelot_ptp_rew_op(skb);
>         }
> 
>         return true;
>   }
> ```
> 
> So for the function ocelot_port_xmit()
> 
> it will be:
> 
> ```
>   static netdev_tx_t ocelot_port_xmit(struct sk_buff *skb, struct
> net_device *dev)
>   {
>         struct ocelot_port_private *priv = netdev_priv(dev);
>         struct ocelot_port *ocelot_port = &priv->port;
>         struct ocelot *ocelot = ocelot_port->ocelot;
>         int port = priv->port.index;
>         u32 rew_op = 0;
> 
>         /* FDMA path: uses its own locking, handle separately */
>         if (static_branch_unlikely(&ocelot_fdma_enabled)) {
>                 if (!ocelot_xmit_timestamp(ocelot, port, skb, &rew_op))
>                         return NETDEV_TX_OK;
> 
>                 ocelot_fdma_inject_frame(ocelot, port, rew_op, skb, dev);
>                 return NETDEV_TX_OK;
>         }
> 
>         /* Register injection path: needs inj_lock held throughout */
>         ocelot_lock_inj_grp(ocelot, 0);
> 
>         if (!ocelot_can_inject(ocelot, 0)) {
>                 ocelot_unlock_inj_grp(ocelot, 0);
>                 return NETDEV_TX_BUSY;
>         }
> 
>         if (!ocelot_xmit_timestamp(ocelot, port, skb, &rew_op)) {
>                 ocelot_unlock_inj_grp(ocelot, 0);
>                 return NETDEV_TX_OK;
>         }
> 
>         ocelot_port_inject_frame(ocelot, port, 0, rew_op, skb);
> 
>         ocelot_unlock_inj_grp(ocelot, 0);
> 
>         consume_skb(skb);
> 
>         return NETDEV_TX_OK;
>   }
> ```
> 
> Feel free to let me know your thoughts!
> 
> I can send a v3 version patch once we're aligned.

The idea is not bad, but I would move one step further.

Refactor the rew_op handling into an ocelot_xmit_timestamp() function as
a first preparatory patch. The logic will need to be called from two
places and it's good not to duplicate it.

Then create two separate ocelot_port_xmit_fdma() and ocelot_port_xmit_inj(),
as a second preparatory patch.

static netdev_tx_t ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
{
	if (static_branch_unlikely(&ocelot_fdma_enabled))
		return ocelot_port_xmit_fdma(skb, dev);

	return ocelot_port_xmit_inj(skb, dev);
}

Now, as the third patch, add the required locking in ocelot_port_xmit_inj().

It's best for the FDMA vs register injection code paths to be as
separate as possible.

