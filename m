Return-Path: <netdev+bounces-223984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C219B7CFA7
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A587586B54
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 11:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892B735A28B;
	Wed, 17 Sep 2025 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcwuxM7Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97EE3570B4
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108452; cv=fail; b=RoUtAXyJOQh7XG90HMfSGbJdv8qn+pSZuXXIVw9+gwqlY0fd5x/0Ak50ahrmn5zl/7yWK4V4A0az2jUfGQi3F+d0Nik6ll72PInzNVSYkAzFTJLieu1FHWWv5wbB/7g+H4Hh40/YAq+I82mrFQCXbBY4EHTAi47KVsviNcP6vbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108452; c=relaxed/simple;
	bh=mv0oMSJ7e8Sk+bjt6MxgT9NvOv268nQdFoWa5OURsPo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HIowpTW5a7r0KvN/dPZaQyhm1QS5DjLvCjAr7ySKQ3ufqmj+9gZmJ/YdcxZNb9wjtnr1phXWXp00XD0CenWBADNITn4PusihKLX7PTTE6VLdW5Gzr8xuvWDhvue9UihpWbpIWJGxdjDsdPdwKGPoKiZZ6jbQnWd/MnKq2ir5OKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcwuxM7Q; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758108451; x=1789644451;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mv0oMSJ7e8Sk+bjt6MxgT9NvOv268nQdFoWa5OURsPo=;
  b=lcwuxM7QJYmDq2yP6qtNqGAq0imabKY41bB/gLiXxJROmEqER6P/9Ixj
   TZE9NFLOaEU9fAH2J1Vv282XPtnC4xZ8mo1g1+FZgdLUTEhx45lX9hEpT
   bKWX9PiyWzyeHDx1IAsY47f6Kkvox1XAYKDH/mlkY6Xi40AgAUgy0fCr8
   tVVt3SiciXHKsxIgYMI5+u85nqlkX4If34ScYSUJgYUpUNvHp5JkNLvX/
   Wl0YmprhNt6yUj6nxzcMrA0K6b3LR9ANz6Q8lmZJpBB5gG/jRS7bJBJ0P
   WMbafpJ7SDO6vgytSUdT89ZcBYZxgI2eUfeiaAfsElgLpZ5gF5LZJpsGS
   w==;
X-CSE-ConnectionGUID: uByPzmCvRGOj3/YfElIh2g==
X-CSE-MsgGUID: g64KFmcoT3iXD2Q+E5pVhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="85850705"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="85850705"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 04:27:30 -0700
X-CSE-ConnectionGUID: ps+LRQTmSnWxCOZIzVCdhw==
X-CSE-MsgGUID: iedlpeScSWOm7oH1tLIf8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="175140752"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 04:27:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 04:27:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 04:27:29 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 04:27:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0fwUWD4JeTot/GEtyHp8Yc5ZKF0/iweMOySFp1GdbUFdB40EmPRsnkKP6dpcLTU6mMoPF5UEPsblTE/bvIGEdI5bn5Z3ZY5WM9dMhyDH+Sh94qiCS6ck9EvVivWWljB/kYXNIzBYe2UkXMm4JJ/kvThtvJKcj6XvJlE49BJxJm4vMD30fN7f5uidleLeXESYqzJwCw3wtTFJdF/p+gEmoV4e6AB5lbY8bdb4nbvzKrhyEZZ5ReNSPtzHDSXGWVyS7V74TYjSiYCXu9G4QkKC5fXrXKqD65OORRJukyGYUkTw/vWsdU1MRcqbozudqtolQvykcOt7fktQ+N7N65fPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mv0oMSJ7e8Sk+bjt6MxgT9NvOv268nQdFoWa5OURsPo=;
 b=Pfh88n2BWnzMTo/3MV1bNreAxXUdiJeQI00hOOlkv8krxBujgXX3Y+hcUUjuZ1GWwGqbxRnae4E+6yZuQWY/nJrfZWPSM/j4PCiONq3kzr3Syze5j2FjyN+v4LwOwtwggb6PVdB+JeeHvBZz9BbsrLA9MlP81GpIKpN4JPWNAN6MPI8xbVvv/j6E7cHVEZwU+vnupEeViL6CYZVzfPMu7pc9bxfoDwSNx3MZNL7h1uhu7qNCpEDnErRqitXQQZhy2gHJgZ69//OSFTxofuwrCnugLqNvA0rhGbfQv4HinNAay+/2PghzXGMksGqm/QMzzd1SOAv6WwZZWqgGEBjfyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB4845.namprd11.prod.outlook.com (2603:10b6:a03:2d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 11:27:26 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 11:27:26 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
	<kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, Donald
 Hunter <donald.hunter@gmail.com>, Carolina Jubran <cjubran@nvidia.com>
CC: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v3 1/4] ethtool: add FEC bins
 histogram report
Thread-Topic: [Intel-wired-lan] [PATCH net-next v3 1/4] ethtool: add FEC bins
 histogram report
Thread-Index: AQHcJz8mendQhFzS/UWAQgEewEAKMbSXPXog
Date: Wed, 17 Sep 2025 11:27:26 +0000
Message-ID: <IA3PR11MB89861635B2B78A559A8EAE12E517A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250916191257.13343-1-vadim.fedorenko@linux.dev>
 <20250916191257.13343-2-vadim.fedorenko@linux.dev>
In-Reply-To: <20250916191257.13343-2-vadim.fedorenko@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB4845:EE_
x-ms-office365-filtering-correlation-id: fb5c0b1e-d850-44a7-f64c-08ddf5dd2e18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?WZmH0pI0mEDisZvx5rugQZWssLwU8R7L6HFak0xgMpN+NBgbPNNwUjYTo7nq?=
 =?us-ascii?Q?p6wIp8psSvMU/ANeT5T4NbOX8hjM01UYnSRDR5ouepu4aKyJpSqXD8SuAXv8?=
 =?us-ascii?Q?tOXGpLVl4iOb9+V++gHbr22dR+CKFWBaRbjWQWJtCSFV1sHfaHMDbX85qtL2?=
 =?us-ascii?Q?X1sEmaRV06kpRNGyQTphUW18sCcg30SbGKdbXq8u+wZaSvgIBJ4mF+HvCAU3?=
 =?us-ascii?Q?c3Itk0ewAQEXTnMFWM5ICw48e2WT4LjTI0CUj4Ye23pEXohbxZHfmhJGHzin?=
 =?us-ascii?Q?8HYiz/2sLBinO8YodphjVj77DrPXnO7MGaCrIzYaPK+UuDTytaPu/m9HDqul?=
 =?us-ascii?Q?/MO0nhWV1QKQ+jXN6JZg+xJ/PKsBkWKbDRUsnDq7TO50+x413ZPWL+C8Awj7?=
 =?us-ascii?Q?fMHHWpAjLwFlSkTS29cy9aZ+ZKWhfvYCLYRJGk4HMkG59t32Guexbrbgy4n4?=
 =?us-ascii?Q?3XIldZcbpQNwCZoEGBk4Svl+fcuJwGUtxrK4k4zfcKoAntgZ9RJMTZwDUZRi?=
 =?us-ascii?Q?rT6ohwb08iR/boqS58XaZGizEporMnYDZHwsBfAlR1QgllQAqQ6Jbii5QWDa?=
 =?us-ascii?Q?Uk1YtNTtz5Q4q+5njB1W12VRd4gbpM8Ei6jHmBkagfrBuMTLL5GeD6dq0tUt?=
 =?us-ascii?Q?xeGPX3AWXTngAy+4/fH/pLvzzPGGaS0pG9LF0df4ygADdRJCNWB/a3NX4OOz?=
 =?us-ascii?Q?YpueC1Sn3x6G/PhnZYra5MmxW9A+CDWO4HnvPQ4gmh9QM5e/wKokMewMbiUl?=
 =?us-ascii?Q?InEWECL9OKkhQbD4qBhGqbGJBy12BKxa3brw8ygGCCBLhda1Kcv+p8LS8yeK?=
 =?us-ascii?Q?lAq8P2ZyeSWfqsXWeafuZ2f09aKJlArg+iLntWKgAlPS/0jpE/eLCFaeBJfd?=
 =?us-ascii?Q?sE8qkrddsA8NddOwpBGnN8s8fZXWruLGdCbkWfEXBjlMY1cAbD864bxETV/g?=
 =?us-ascii?Q?jO31gBF8/4ALYcSI4/HOaVrxVI3dw8KFaZj6UdxwX3p5pK2d4dOAWUlZ2h7+?=
 =?us-ascii?Q?6++LIf/eAnvmeZ4diMdcWxA5Z8kmOonAMDdlxtq1Llwxt1KCGyw3180GBpU/?=
 =?us-ascii?Q?8MJ8z4fo+wWsGIvOVXxHXjiZe7eTZ5vafLJQflEQNvGGIMvUQxYA13X0wLKy?=
 =?us-ascii?Q?tG88gDqZl8zPLp8AxD8aDGWCHNqHaAKzf676KhJyrWJPjRaPlXyJlEQkUkf0?=
 =?us-ascii?Q?RzSKLMW2lF7McOmxH5LQGpZkRF6KMtQyfsofCoJ/5O67hJZ88pfGddsz8+iz?=
 =?us-ascii?Q?HH5lsvc+n+sis7ROOi0IfwjTZ6M9YFfs7jZNk1dvH+ALJtIu0ISGB60AfRiR?=
 =?us-ascii?Q?X2J2GcBRgy5SvO70A3mmjofC7nbcpWukHfUISx0mu6rIeYdCGCH10QjLT13u?=
 =?us-ascii?Q?qYlUpbUbAYJF6Nj7XT3SUSEQrzMXRTcyLJCvf3RsgwJ6wkyW0TzvDa0XzmBF?=
 =?us-ascii?Q?Jlni3/BPz/hgwZ/fEmlJof5CE4/Z/yXEuJLVheDtswyMz3nsyc0alKPuG1Yg?=
 =?us-ascii?Q?oRKZ+wCGZ7lASXg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yht5UidNOOU4kZNmUMOIygovqo3OI9pBPGaYb4qp3w6oHLw8dFbs+iNif2t7?=
 =?us-ascii?Q?Tg/OPNMSWrTYN9r6GTWvX7tJGSvIb4oSRYOGZ6oOI+H1P4SJN+jmw/6Sl6EN?=
 =?us-ascii?Q?QSo+RJ8SC00AARr1z8b9l03XzDlNIDNFrghwGNDRhC878kdkuHbunhOllL9W?=
 =?us-ascii?Q?4/u27E0JsUXz3v50JdUhHMBjdcbA2U02uAkRKGl9IegF1AbmawMsZJYI2Czc?=
 =?us-ascii?Q?yow9Ef/AQLJebmSNczl5peK0PGEAcWezVr1TRKhL1bS/QM3wr3LDri6c8hwk?=
 =?us-ascii?Q?5KJqg2atVD/RAR3ogibTPtcVEzLpYW+0twSk9o9BDcnNI1o1xrrVnuyzSC9U?=
 =?us-ascii?Q?zETZNoNY4aY8EhZ1tCGYEZW0RHLdvIU3nCmxjtqfzeLOc/O60Saw92pl0FoF?=
 =?us-ascii?Q?jYCqW6fFZP39tS8ybATwjt4gDuypAaj8ufAWFiVAAWQLCuKNAza/vdjpKH37?=
 =?us-ascii?Q?STErTBaQGZhYh4ZKVb2VqcQgJ/PyCZFoh9KADdjg7cE8OCaBUskQM3ACgAqj?=
 =?us-ascii?Q?7dVImuIC+2owhrgER6rbFAkzKOyras2Egl3nly6NozQX+jrQVOjs79OmqQKE?=
 =?us-ascii?Q?KqaVFPPosovEm0shmqX2YU320Zi1L/YINKDTb76osoATL0sIcR3ORQbwC9vJ?=
 =?us-ascii?Q?qSTOmorR5Dr3W7YFgJJyyJ1kW1GRYAKok8+2fjcOvXHkspx7Wb5Z2a3kj+/K?=
 =?us-ascii?Q?nAy11U6xe9FCdI1RW0plnKZhw3li79ebDgDcwCm9OhlPhzcE5hUihqSF4KtL?=
 =?us-ascii?Q?nQj1jLCZUf//QTUbqf+zkVaoD3z3DjiPrpJpI3yZ8ccmOWfo98xCQiCZgN/U?=
 =?us-ascii?Q?SBqxlHdR2lFTBWI/eYL1XdV0qlHu3qexhkiMW27AgYcZRyk0K4r42nS5bfIY?=
 =?us-ascii?Q?P/tkfwe1wvK5N8NmJaDTnhzBvGZAEd+6dv+tMz4Q18ZUxgbc26GyjxxLYnnu?=
 =?us-ascii?Q?qckoI0o38KMRAA0MgELqBBGQSTpuT9/e8v34e3oAsCC+kZr/ZS4nYbsNegLT?=
 =?us-ascii?Q?xUjMqLY2r4c4YaA+cpcdPZPM67/VLUBfA7PHLQ01Hc/vVeJ6mK+qZqpLCHP8?=
 =?us-ascii?Q?DI83s4a8Kd7J21mqhJUio/TXv5AWqJUboSGxedW7I0+ci9CevnB/PqWee/68?=
 =?us-ascii?Q?1mGrGB8g6nychFW9qD695Qu8cY6zemHpO7FwRq/i7q24DctxaH2bEZoXs+u3?=
 =?us-ascii?Q?65u74uhqMEvoZX73cUS/lPoHg0UqLvpqYrCWj7zoI447oUEnr0DfFDYubk+q?=
 =?us-ascii?Q?nji5ivgECo3CVj6Lh/UDIweMS1tEAOS8ZKuAhcKdD/kdyGW7zdYfKmNEKPUY?=
 =?us-ascii?Q?k9RcnDcf8sNr2yvKzHMEQNzA2y+Pyvh5QQyhVIjzesuHKJmFlRW5GyQgzBuz?=
 =?us-ascii?Q?/NOPh2BJAxKBWryNYSfuT7ClFhFqVAlZ8/su+Uo10VqA5PoKjnaApf0u36Ih?=
 =?us-ascii?Q?BIsobb3toL0PlVuwNRvoixfL7gWvdemNPqmetYuhfRsqKHiebPbWQ60fCYfU?=
 =?us-ascii?Q?ckCe6bi3nhaVAezNwSyTABYynzLAY+UySkt3yYutCpbldDPXCZ+uppBPcwcb?=
 =?us-ascii?Q?jvWla9mpgFaca5w+vNy/Ao0zHuMK7tI36alspmjCqFD7cXGz02YlPFVQ15pP?=
 =?us-ascii?Q?tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5c0b1e-d850-44a7-f64c-08ddf5dd2e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 11:27:26.6200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5OY2rCznSV/Fg9y6q/Dfz4vJ3B/L6u0r8HD8Xui2Ln5GQASt4gOaf5pMrbKIrQfi5lf+MJv6v48kf0pql6rhaMV0/AM6kK3VzGOvxiAHLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4845
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Vadim Fedorenko
> Sent: Tuesday, September 16, 2025 9:13 PM
> To: Jakub Kicinski <kuba@kernel.org>; Andrew Lunn <andrew@lunn.ch>;
> Michael Chan <michael.chan@broadcom.com>; Pavan Chebbi
> <pavan.chebbi@broadcom.com>; Tariq Toukan <tariqt@nvidia.com>; Gal
> Pressman <gal@nvidia.com>; intel-wired-lan@lists.osuosl.org; Donald
> Hunter <donald.hunter@gmail.com>; Carolina Jubran
> <cjubran@nvidia.com>; Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Paolo Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>;
> netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 1/4] ethtool: add FEC
> bins histogram report
>=20
> IEEE 802.3ck-2022 defines counters for FEC bins and 802.3df-2024
> clarifies it a bit further. Implement reporting interface through as
> addition to FEC stats available in ethtool.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> ---
...=20
> --
> 2.47.3


