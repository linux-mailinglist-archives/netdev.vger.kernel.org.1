Return-Path: <netdev+bounces-93932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34218BDA85
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 07:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F1B2822D9
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 05:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A2C6AFAE;
	Tue,  7 May 2024 05:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cRN+GFAL";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UVGxnwei"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA546A8CF;
	Tue,  7 May 2024 05:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715058479; cv=fail; b=gInWdWl37aN4Nf4F2GFjlP0oGAp9WkR3NkAqGnGVKY9/pGqP82LJqjBsCjjj2Ma07+Ssrcx6nCoYNFlBd8e61xTI/xq5oUeDF5Mkxv8hOxB2iSdDUoh00gmA40I7bVtbpNCKvOKkv+EpheCu8ds9LsRXJLgJLZ5hKAMJmsUUje0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715058479; c=relaxed/simple;
	bh=NGiQr4iM5eqUFNJz8nr26eXUa8Mvkk+K4tGc/CMeyPo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LoM8F/LgFHZhj+5XQgzdJvTI0+yttC2sW89coX1tm1xfxx0iVmPXgVapcpvkxBNh1J7cuSllcZtf4sabCV53GtHfzLON7kxpD6Y3InZVJXekMf1rtUn33s14g7FJch5K3tqdGwCm3kg9ZLmmVIKg/4rElCxEEBdzKY+ROAxEdqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cRN+GFAL; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UVGxnwei; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715058477; x=1746594477;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=NGiQr4iM5eqUFNJz8nr26eXUa8Mvkk+K4tGc/CMeyPo=;
  b=cRN+GFALYX+i61yE4UfTp/YYYUgVr8wDElqnIV8Ongb7W9chKqyvH1Q4
   IpxG3Vtg0h3KWeuKM6N4ul8973sZukYrx64fzJ2W6kgvv/7A2y9mf5KFx
   yyD7EGTKMhoSINoyuwIDSKtKhkgqyNLdMinoxuGUevjyU8fsShIvsWW6N
   KsTVSYED7coQkZbd9u8BDam2u2irUVYHsnDfE2JdVuQsny4ozEaIISE1m
   yogs7RkxlY8BFKOWe/rz8f/tFXHkUtJ7po6K10iqpg/RAf0a11g3SJZLN
   bQJVDs8KGrPeIrmsQm9i4mCNAp1bwsc2TSp4yLZ543JWJNLv7TFlU71eQ
   w==;
X-CSE-ConnectionGUID: dyN5i1OgT9yWgAjs8tx+ew==
X-CSE-MsgGUID: 816nKeBMRTa/uX+Uu+3mLA==
X-IronPort-AV: E=Sophos;i="6.07,260,1708412400"; 
   d="scan'208";a="254744460"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2024 22:07:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 22:07:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 22:07:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj8mSCoFz8CmcIDkfx4mULqOGKjvV3thXIRNfpdqRhuDpkfzzjXOkPlEmRtCUv8MsGy1djNKEBHUtWxg9Avl2cGzbb1s/vqtPJiC1mKahOdFMImmHgDD4WVj9t8qpHJ1RxfDR7jonbAdCLxhRX0CDmpTcDU8GdR8CZnAVYOScio3MFoDSjyCwYpxLZu8cixSRft2toKaerGxOJb9kpuK/eF98cHGfOHcpQNoyDV2mu8cH1m07MaZfIBHSCrtELKkIdfYOOwNU/7vpigrLn8SXpTpR//O/EhJDd/L6pqtukXhM8Stg0ZvCd2A/dlAbITcc9STNdevdo4gqEHbGtoMhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGiQr4iM5eqUFNJz8nr26eXUa8Mvkk+K4tGc/CMeyPo=;
 b=XkuEPSOC0mPdV3o/L6ddSAtoEn27DeA3UMNWVrPQ7qK80iHcCOY3N7pQz/qaRBsf6uhd2oFCd4xmYjqZNXXNsb7p0tPIt+2Z76afo8POlfJXRosKn93s/eajKEE1ijJ5q9D+jd9ujSqtTcBtAUhnT6a9pAi08biVxBCFlI7/GiOWjFtfP+LUHcXdQ+e0TW9eB1KYZ/RzLbsPC0bAw7Cssrnk9TusxmY2XfkLvAt5v5a8MIuV2qe1CKZLdaj1eF/MjfFJz1kTGizm4/6l6JZ7vaPBlFZo50Rp0zcDP243XA7fxZz3rSADTLgQGR77tS3mlx3BuQkuRJKWeOcm0xJW6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGiQr4iM5eqUFNJz8nr26eXUa8Mvkk+K4tGc/CMeyPo=;
 b=UVGxnweiSoL8MqZT3er8I8TBp/0kpYrnEX6b9E+HvfUfNlKBkEgFyVur5Myj6d3zRrtMctxe18vZ6eq2J1xaBcBPRZ3vx+Ndp6EKgbN3MZpdzsSxJtKyGLO9Ntr+K4nO48dZWSkdXloBQeSHl0jjTjqvcGe2gvmEjqS9CwVtScz8s2VvK2VnzWnQac5bQwzy5pxmUvh5lgaDwMIsfPxol4yjuxAw2X6Le50lGjiUfA5g+wjXq7FLkxT90FJonizVorydcEd1vJXnwpqkojNUcL2BPQWucOqPMicuMCiB7Wl9YB9H5Krmkl1NCPqgt8LcPqamfBm9s/7rO6Te/iZe+Q==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by SA2PR11MB4810.namprd11.prod.outlook.com (2603:10b6:806:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 05:07:27 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f%5]) with mapi id 15.20.7544.029; Tue, 7 May 2024
 05:07:26 +0000
From: <Rengarajan.S@microchip.com>
To: <linux-usb@vger.kernel.org>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<UNGLinuxDriver@microchip.com>, <kuba@kernel.org>
Subject: Re: [PATCH net v1] lan78xx: Fix crash with multiple device attach
Thread-Topic: [PATCH net v1] lan78xx: Fix crash with multiple device attach
Thread-Index: AQHanE12SFIEQHuItUOzC3mq+bjTZbGJ+bKAgAFHa4A=
Date: Tue, 7 May 2024 05:07:26 +0000
Message-ID: <26d7f478dfa81cadd246771fb41c6763a4b19772.camel@microchip.com>
References: <20240502045748.37627-1-rengarajan.s@microchip.com>
	 <1706dd2a3d24462780599f57e379fa2a1e8e15ac.camel@redhat.com>
In-Reply-To: <1706dd2a3d24462780599f57e379fa2a1e8e15ac.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|SA2PR11MB4810:EE_
x-ms-office365-filtering-correlation-id: d89d79b7-d398-497c-4958-08dc6e53969e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?blo1ZHNJb21BUVNjWUxCSEI2KzBDNGFESmZ5MWplNGUrSmZQRVlkSFhPWG1a?=
 =?utf-8?B?eTFZWStVNnB1b2cvTDF1QlpJelE5R0ZSdWNyTFhxYjVLc0ZEUldQTjFVU2RT?=
 =?utf-8?B?aklhdFppSk9iMzZ4RVJPRTBBenRzOGV5clEwZ0FZNUJDSWVQamN6Zm1uZUVk?=
 =?utf-8?B?eklCY0ZIY05MRTRGSHVDN2FCUjFyV0MwUWFPdWlyZi90eUx5UVVUSFAvN3ZT?=
 =?utf-8?B?YmlQb1p2RVA1dGxKcUxVMHRwZ1ZaWGRKamYwWXA0enNPbVBlazlOZWdiZkJL?=
 =?utf-8?B?THJmN1FLTldrMVZwQlJ5Q1ZzbmdDRFVzalRybWkrRm40SnpkZlBVS1VhU0JK?=
 =?utf-8?B?OWFpbyt4bmFtZHdRVlRNbmt0Vkp1cWsrMFZPRThqQ3hBZllOWjdnRDI4T2ly?=
 =?utf-8?B?K2RFeGhJZjR6c0dJaGpseHBsVGlPV3lmSE5iMVhuTlBlb3J5WWVDWkxHR2NI?=
 =?utf-8?B?a3JTNW5kS1pZcVp4WkpZNnphcjc3L0FhdmlnWDJrY1d5bXk5VjB6b2VFeisw?=
 =?utf-8?B?NTJBTzZsam5uSGZqN1hXZTAxbjJTd2N4Z09VSmIvMTdraENGR1BSaGRFdmNq?=
 =?utf-8?B?cFlCZmJ6dTVVd0xlZ1RRa0lhaHhCdTRmamx1ZGV4cGxqdXYrR2Jya0dlMFVW?=
 =?utf-8?B?eUE2YmdOSnF1SGlOcDFTTkFET01IMDlrd1BUSUwxTitQVmRnVzRKemJ1K085?=
 =?utf-8?B?MS92enVxaEtXbUZ2WXdRZ2hGbTJoOFpiM201UWtNUWU0QlNHVSs0eWl4c3Q5?=
 =?utf-8?B?cG5DaGNWNk55cWJRWHcrRW5MZ0FQYXZ5UzQrN21ZZHFINGIwbzJnRTRpNE5n?=
 =?utf-8?B?MEVSNFhoNllrUFFBdEJzbGRpWEU4L25ZMElRLzRJNzViRjdBNXFOa3c1ek5U?=
 =?utf-8?B?SnZCaWd3cWpCcW1LN0IzU2pUOHZhWjV0SkhYZkFTSUJoSFExNmdpUFRkNVFx?=
 =?utf-8?B?UVdyVEEyUkRQN2lscmtteXc3NjlobkNkN01zWW1xN1JydlRoditXVnZOM3Yy?=
 =?utf-8?B?aGZxaDZLSTVrRFhIUkY1NGppaWQxOE5WZEhUUlFxVlBRQktsejFkK21RQVY4?=
 =?utf-8?B?ZEs2RWt0ZlF0dDBwcmJVRG5FckFiVE5OUUtCbmdrOXRYNVlBLzJ5bUVYSUFF?=
 =?utf-8?B?cDk2WS9ZT3NzbGhBRCtyanJSZWpFS0FOMEZZYlVRSE9TeTFxY1pLcFNXRi9X?=
 =?utf-8?B?UFRCVDRiektnOUNGSTN1YlNEa1RIeER5OTRES3Q5Mllsc1JNd2FDNjdnT0hW?=
 =?utf-8?B?R1RTdjJoZWx5ZmNqTjVpTzdnRnRJdWE3WXRObzVzSytnc3hSWUl4bWxvRjdN?=
 =?utf-8?B?OWZnRTVCSTFoc1JaMlNwNzlQMzRjNmZ0RTgxQ1FuVkZ2N0Q0eHgyREliVlU3?=
 =?utf-8?B?V1kwUjJ1QUNkbEI5aytyVW83Mk1hdllrUmtKVlZubTVCK1k5ejY4QnF5ekRX?=
 =?utf-8?B?bEsvT3hvRkJUbjhjYjRzSFhIWWkrNlZiMnVEL3FHZnlOZysvaTJkUUdONGhC?=
 =?utf-8?B?cnpKSmlyME0xQlFqbjY2VmlJazYwcUpEMEhXUXpNVmxuWUtEUHlTTUQ2cTRu?=
 =?utf-8?B?aHcrSzBpNWkwbFpNVnJETVhsNTNGU1dyaldpQWdDTDVhUzFrTHhYMXVPc3lR?=
 =?utf-8?B?QWExVkJsa21xdzRXZkxtb05RQ29JREtscThiMVM5U1NPdkkvelRGL25yNkFs?=
 =?utf-8?B?T1NxemFFUEswV2JzZ3l2TUtSRkZxeWVoU0tBZkkxUXVobG9LUk1namlmTDdt?=
 =?utf-8?B?VjRVNVFLMU16QmVBMTNFR1RWc2JWUFFvQ3dTTnBCeHl5bFViWTJVZmgzbVQ0?=
 =?utf-8?B?bGtJREVtNzh1bTl0WlpaZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGFxTHNYdjlsa3E0Zlp2aGlpYXZJTzAwR0RLcFpzZ01DMWpJSU05U0hwNGNm?=
 =?utf-8?B?eUZRV3hWVHFaUDNXbUhrNGZ3L214cDhYNVFyZ2NpdnVXU3VLV01YTCtpRE1B?=
 =?utf-8?B?WW1MUUxNc29kek1Ba1JweFVsNGZYZnlucEEybkZZR0wwRjdhcFBEbVhiM0pL?=
 =?utf-8?B?VGdSU0NBdG9jV3NJckdHdWVlMFlmc3pBekE2SlhuVGNSRVg2THVMckdEY3Jx?=
 =?utf-8?B?K2JmWlFubjV3NWFyTzhGVWtPa05CZ0pHMEZEUzRkMXJENDJtZUNvVlJwYWJm?=
 =?utf-8?B?VUhBT20xYjh4SzVZbUY2Qk1OTFk5dzZUQU9odGg3bm5GWnNUTSszd0tIZWxa?=
 =?utf-8?B?eDdQbTlkZEhSM285TnR5SjUrc3ZxQnVwb3JydkEwdytkeitlbzFxRTRFanlO?=
 =?utf-8?B?UDMraVJCUzR3RHhrbWxiNUJqblZMVGR1ZkJPOW4wRFAwMjFWVG5CbEVYQ2Ew?=
 =?utf-8?B?emEzQzNzdWhTQ1BESnpTcTRwZFN6czh2czMybTc0OE95REFLL2FZMDZjbzZ5?=
 =?utf-8?B?OWVtL3ZHbm5BcXEwdTRsczlreVBkQlZWYkxJeWcvRmxVS3YvbDcrT0U0cmE5?=
 =?utf-8?B?RU1lem1YOTA3a3k3NFNZcTM2VUpHMk5kQkZSR1FJRE5pVHFOb2tFUllCRXkz?=
 =?utf-8?B?TWJlM0tVTXZZR2x3MDdmY0JyQ1ZrN0VlMSt3Q3orNHM1aTUwTndkbzZnQXRB?=
 =?utf-8?B?UjAyelc3UUhCZnNyNFBBUUpidFdpSkZxWHppYlRjRElNZEI3cXR2cnFSU2Ir?=
 =?utf-8?B?M3JxakpUeG8vb3JMUWNZdE1tR2I2amRTSEwxckVCMFJRdDRlQWlyYlFjTzFo?=
 =?utf-8?B?ZG00dXo2L3p1d2ZqZGxNNTVIcEFOVW4xY1lxZEFwVlVQUk1TQkhhd3ZKRDVi?=
 =?utf-8?B?QW4yTUhqTTl5STljS0E0MDEvSS9VNEZ1QXl1NmNLSk5wUERqSkJkSU9CQjE0?=
 =?utf-8?B?UkJNczZhN3FJVFZGeDFyaUhSM0tmaEZXcmg4bVQ3RnY4V1hTeENCNDV2TjFH?=
 =?utf-8?B?c3BkL0k3RHZvS3NNNWhVcjN2clV1cEh1MDZHV05LRU80cEMra0hYU25Wb0Zi?=
 =?utf-8?B?Y0wvcG9nbHlXNkluL2NhbWoxTlh4ZHhRYXppeGZWcmcrb1B2VXUzUjY1VVFT?=
 =?utf-8?B?eFV0eTN1NVl5THQyaG5EbEdHeUpNU1ZYaTAwZVdmKytTUi9XVy83bGZYaDBo?=
 =?utf-8?B?Ulk0NWRRbXR2T1BPVkpVblhaY0Q1VFhtL3kvZjFJYmxpdHdmNWI4cHVOeHdx?=
 =?utf-8?B?dzZ5OVNuWllOREdsVitpamMyUnNtaXJzTWRTeTVxYnJtWjJYWXZYUnA5QXhB?=
 =?utf-8?B?ek1HMW1VMEpJL0kwWXRCN1JwQnhGWGFYcHRENWJUVnRuTEszbnVrVmNmbFMx?=
 =?utf-8?B?dGp4blpjUkhmZXVxK3djOFZmWjgrRW9GajhXeDV0bE9INlJjUUFyeTlDeTJG?=
 =?utf-8?B?Y0xUUFFwbDRjU3NjcGVkeEt5ZE5FOU9BOEErWXhGTmJxU05sOW90bTZRVmlW?=
 =?utf-8?B?NW96V0taZVdPRllua2dsSTlsNVhTY2FraUZtMmduUktyY3BRRWJ0RlFzWEZY?=
 =?utf-8?B?OEtYL3ltMWg5TDFwWkR4Nk5iZlh6ajNBU3p6NkVXRDVYM2I2d1FDcVZ3UTMy?=
 =?utf-8?B?aFBqN3JVbFZJR3MvR29IR0Fxb0xmeHBEMzZNZ256d2VjbDBRa3AzY0hBNVVJ?=
 =?utf-8?B?YTBadEM4d0x3VW1JUnhXTTRsNHJjQTdJM2NmVkNIVkswaExWWU1QdmN6RHBX?=
 =?utf-8?B?SUM4NnRyb1JpeHp1VHpKOE4waVBQaWp2bDlqdDgzZ0orRVNJa2pNNzFUd1NC?=
 =?utf-8?B?NTdsZGNVbThzcXcxdGR1TE4rOUVuUDlsc2pPUFd1Y2Jsek05d2FnOVgrajV1?=
 =?utf-8?B?aGp0c1k2RFRoRjYyeU1TM2YzTStMN09Ubmp0SjJVOWh6cy9VN3ZNSWMrZTQv?=
 =?utf-8?B?Nno5R2pBYlpxR1hIR1d2ci82WDRYSFc4RFlZZXJ0NWRXWnY5V2xtZklmQXBs?=
 =?utf-8?B?MlQ5R01pWXJrNTRsbEM5cXhiZG8ybWZCaGVqaXBIYkJuQzkvdHNXR2czYkhU?=
 =?utf-8?B?aGNvUXpiQTAwSGVHbXRuWlQvOEltci9TTkpZckVzaFFPVXlqTE1WNFRqOHE2?=
 =?utf-8?B?WVlmb2xFeGlseC8vVDd0R2ZsS08yNjNpaDIyYzMzclRJSno1T09XT0ZCL2FH?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E56E234D6B08FB459D6ABCFB06854199@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89d79b7-d398-497c-4958-08dc6e53969e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 05:07:26.7669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75gBFX/tHUpZ8M5ALP1IKPu4+Rt88swkUfEhAM/kzYIldkjvoDm3ULRZSUz7x04YjYKBfgZSZCuWe9iUIMRskNJJ/pXCSF0USRftBV5AD/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4810

SGkgUGFvbG8sIFRoYW5rcyBmb3IgUmV2aWV3aW5nIHRoZSBwYXRjaC4gUGxlYXNlIGZpbmQgbXkg
Y29tbWVudHMKaW5saW5lLgoKT24gTW9uLCAyMDI0LTA1LTA2IGF0IDExOjM4ICswMjAwLCBQYW9s
byBBYmVuaSB3cm90ZToKPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHBhYmVuaUBy
ZWRoYXQuY29tLiBMZWFybiB3aHkgdGhpcyBpcwo+IGltcG9ydGFudCBhdCBodHRwczovL2FrYS5t
cy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb27CoF0KPiAKPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQo+IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQo+IAo+IE9uIFRodSwgMjAyNC0wNS0wMiBhdCAxMDoyNyArMDUz
MCwgUmVuZ2FyYWphbiBTIHdyb3RlOgo+ID4gQWZ0ZXIgdGhlIGZpcnN0IGRldmljZShNQUMgKyBQ
SFkpIGlzIGF0dGFjaGVkLCB0aGUgY29ycmVzcG9uZGluZwo+ID4gZml4dXAgZ2V0cyByZWdpc3Rl
cmVkIGFuZCBiZWZvcmUgaXQgaXMgdW5yZWdpc3RlcmVkIG5leHQgZGV2aWNlCj4gPiBpcyBhdHRh
Y2hlZCBjYXVzaW5nIHRoZSBkZXYgcG9pbnRlciBvZiBzZWNvbmQgZGV2aWNlIHRvIGJlIE5VTEwu
Cj4gPiBGaXhlZCB0aGUgaXNzdWUgd2l0aCBtdWx0aXBsZSBQSFkgYXR0YWNoIGJ5IHVucmVnaXN0
ZXJpbmcgUEhZCj4gPiBhdCB0aGUgZW5kIG9mIHByb2JlLiBSZW1vdmVkIHRoZSB1bnJlZ2lzdHJh
dGlvbiBkdXJpbmcgcGh5X2luaXQKPiA+IHNpbmNlIHRoZSBoYW5kbGluZyBoYXMgYmVlbiB0YWtl
biBjYXJlIGluIHByb2JlLgo+IAo+IFRoZSBhYm92ZSBkZXNjcmlwdGlvbiBpcyB1bmNsZWFyIHRv
IG1lLiBDb3VsZCB5b3UgcGxlYXNlIGxpc3QgdGhlCj4gZXhhY3QKPiBzZXF1ZW5jZSBvZiBldmVu
dHMvY2FsbHMgdGhhdCBsZWFkIHRvIHRoZSBwcm9ibGVtPwoKVGhlIGlzc3VlIHdhcyB3aGVuIGR1
YWwgc2V0dXAgb2YgTEFONzgwMSB3aXRoIGFuIGV4dGVybmFsIFBIWShMQU44ODQxCmluIHRoaXMg
Y2FzZSkgYXJlIGNvbm5lY3RlZCB0byB0aGUgc2FtZSBEVVQgUEMsIHRoZSBQQyBnb3QgaGFuZ2Vk
LiBUaGUKaXNzdWUgaW4gc2VlbiB3aXRoIGV4dGVybmFsIHBoeXMgb25seSBhbmQgbm90IG9ic2Vy
dmVkIGluIGNhc2Ugb2YKaW50ZXJuYWwgUEhZIGJlaW5nIGNvbm5lY3RlZChMQU43ODAwKS4gV2hl
biB3ZSBsb29rZWQgaW50byB0aGUgY29kZQpmbG93IHdlIGZvdW5kIHRoYXQgaW4gcGh5X3NjYW5f
Zml4dXAgYWxsb2NhdGVzIGEgZGV2IGZvciB0aGUgZmlyc3QKZGV2aWNlLiBCZWZvcmUgaXQgaXMg
dW5yZWdpc3RlcmVkLCB0aGUgc2Vjb25kIGRldmljZSBpcyBhdHRhY2hlZCBhbmQKc2luY2Ugd2Ug
YWxyZWFkeSBoYXZlIGEgcGh5ZGV2IGl0IGlnbm9yZXMgYW5kIGRvZXMgbm90IGFsbG9jYXRlIGRl
diBmb3IKc2Vjb25kIGRldmljZS4gVGhpcyBpcyB0aGUgcmVhc29uIHdoeSB3ZSB1bnJlZ2lzdGVy
IHRoZSBmaXJzdCBkZXZpY2UKYmVmb3JlIHRoZSBzZWNvbmQgZGV2aWNlIGF0dGFjaC4KCj4gCj4g
PiBGaXhlczogODliMzZmYjVlNTMyICgibGFuNzh4eDogTGFuNzgwMSBTdXBwb3J0IGZvciBGaXhl
ZCBQSFkiKQo+ID4gU2lnbmVkLW9mZi1ieTogUmVuZ2FyYWphbiBTIDxyZW5nYXJhamFuLnNAbWlj
cm9jaGlwLmNvbT4KPiA+IC0tLQo+ID4gCj4gPiDCoGRyaXZlcnMvbmV0L3VzYi9sYW43OHh4LmMg
fCAxNiArKysrKysrKystLS0tLS0tCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMo
KyksIDcgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC91c2Iv
bGFuNzh4eC5jIGIvZHJpdmVycy9uZXQvdXNiL2xhbjc4eHguYwo+ID4gaW5kZXggNWFkZDQxNDVk
Li4zZWM3OTYyMGYgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC91c2IvbGFuNzh4eC5jCj4g
PiArKysgYi9kcml2ZXJzL25ldC91c2IvbGFuNzh4eC5jCj4gPiBAQCAtMjM4MywxNCArMjM4Myw4
IEBAIHN0YXRpYyBpbnQgbGFuNzh4eF9waHlfaW5pdChzdHJ1Y3QKPiA+IGxhbjc4eHhfbmV0ICpk
ZXYpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXRkZXZfZXJyKGRldi0+bmV0LCAi
Y2FuJ3QgYXR0YWNoIFBIWSB0byAlc1xuIiwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXYtPm1kaW9idXMtPmlkKTsKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIChkZXYtPmNoaXBpZCA9PSBJRF9SRVZfQ0hJUF9JRF83ODAxXykg
ewo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHBoeV9p
c19wc2V1ZG9fZml4ZWRfbGluayhwaHlkZXYpKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocGh5X2lzX3BzZXVkb19maXhlZF9saW5rKHBoeWRldikp
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGZpeGVkX3BoeV91bnJlZ2lzdGVyKHBoeWRldik7Cj4gPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+ID4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiBwaHlfdW5yZWdpc3Rl
cl9maXh1cF9mb3JfdWlkKFBIWV9LU1o5MDMxUk5YLAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gMHhmZmZmZmZmMCk7Cj4g
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAKPiA+IHBoeV91bnJlZ2lzdGVyX2ZpeHVwX2Zvcl91aWQoUEhZX0xBTjg4MzUsCj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4g
PiAweGZmZmZmZmYwKTsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiAtRUlPOwo+ID4gwqDCoMKgwqDCoCB9Cj4gPiBAQCAtNDQ1OCw2
ICs0NDUyLDE0IEBAIHN0YXRpYyBpbnQgbGFuNzh4eF9wcm9iZShzdHJ1Y3QKPiA+IHVzYl9pbnRl
cmZhY2UgKmludGYsCj4gPiDCoMKgwqDCoMKgIHBtX3J1bnRpbWVfc2V0X2F1dG9zdXNwZW5kX2Rl
bGF5KCZ1ZGV2LT5kZXYsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERFRkFVTFRfQVVUT1NVU1BF
TkRfREVMQVkpOwo+ID4gCj4gPiArwqDCoMKgwqAgLyogVW5yZWdpc3RlcmluZyBGaXh1cCB0byBh
dm9pZCBjcmFzaCB3aXRoIG11bHRpcGxlIGRldmljZQo+ID4gK8KgwqDCoMKgwqAgKiBhdHRhY2gu
Cj4gPiArwqDCoMKgwqDCoCAqLwo+ID4gK8KgwqDCoMKgIHBoeV91bnJlZ2lzdGVyX2ZpeHVwX2Zv
cl91aWQoUEhZX0tTWjkwMzFSTlgsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4ZmZmZmZmZjApOwo+ID4gK8Kg
wqDCoMKgIHBoeV91bnJlZ2lzdGVyX2ZpeHVwX2Zvcl91aWQoUEhZX0xBTjg4MzUsCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDB4ZmZmZmZmZjApOwo+ID4gKwo+IAo+IE1pbm9yIG5pdDogdGhlIGFib3ZlIDIgc3Rh
dG1lbnRzIGNhbiBub3cgZml0IGEgc2luZ2xlIGxpbmUgZWFjaC4KClN1cmUuIFdpbGwgdXBkYXRl
IGl0IGluIHRoZSBuZXh0IHJldmlzaW9uLgoKPiAKPiBUaGFua3MsCj4gCj4gUGFvbG8KPiAKCg==

