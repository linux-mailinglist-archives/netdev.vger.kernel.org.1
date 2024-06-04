Return-Path: <netdev+bounces-100685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C100C8FB97A
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E370F1C21433
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0471487DD;
	Tue,  4 Jun 2024 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vsCx4ply";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UPfJbvZc"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00706171BA
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519738; cv=fail; b=JgtNUL3KrC2w0dmh6oEQciTyL+07KCDShPOhzzo+yEYR98ahmRQJFH30361rcaL9mEPWFaWrmRe5YDGVQl5R8XiqCt1YPwcHwC4dm6LhY2LYk2vmMde6mrpYINkxAEIqrWJoWsgMDh2muIfmyDYZ5iQhDXocMDKnFJyobInRI/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519738; c=relaxed/simple;
	bh=ZVTjkO5OnyfweJjhxuVLuASXr60uHAAvE3h3f0WRaeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XC/6pOLlKb6Ijw96GfukakWsuvkx+0uiq+2N57ZiJYfupUgf9jTygGoleJUfpwKmCsE+yNB1ut16kFd3T5UuvRG99aHLervsRJnrjBpBOZ1T6kbj8wvNV5efoLAKrJ5neFqJYidtGZCp8mBLynTeI+V9b28zb1+VihOAspZowIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vsCx4ply; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UPfJbvZc; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717519735; x=1749055735;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZVTjkO5OnyfweJjhxuVLuASXr60uHAAvE3h3f0WRaeY=;
  b=vsCx4plyKQELvmimOcHupOXC2B4SshbtRc/k7GNJxtx2TK6qaHcFmhKg
   ewnlCbe3RwPQ5i5QEm7VY8mqmU1T8pP1lRkbGdF/hl2LxtE/53+KDUy5e
   FkTeNtYTSfU5FPp2Tb97802LZjeP6ZGP/rrCObndvfHLP0jtlgybG03Gp
   D7RdJNIYh2qk16TTxkmSen4W8On11CT7P60C7/qnv+OWzw6aSCCXv/XYR
   wEBUXx4SfQknTmQz4DdE2mPhsXCeadqEL6CifGYpCsCDoi/S2m0omO/Gt
   TYkldjeucawVnt18PsXYjlwGy7aJsFRiS/eUIXy/SZTfzsaztcYlWcjH+
   A==;
X-CSE-ConnectionGUID: zXSpQoycQom0qnhDh77YFg==
X-CSE-MsgGUID: 29q1+dKcT4alpDrEreuQWQ==
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="257811901"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jun 2024 09:48:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 4 Jun 2024 09:48:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 4 Jun 2024 09:48:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNlNyqFIRFi3Uq5T1CeeueGISrClgH+kz0t7G3R2RI2ga67Dvj+n3WZ2bSFNFoB845QGd0/SXqj9X4UfAr1ngBi8tcx3be58jTc/PyFTY8CypG80rvA/lODZt860fL4cpQXOUFT2Fe4YatBRHl3FJbsxcikuwPel3Cxwk4/PLmnROdohwA0UtKST9fLtfn3a4evg3Eoqu8lr4F43bPZ5pH5sBST7JSysEhSWpC6v+lqfRUWi+Hhi2AEmxnuRzPMmBbRpiafEqu9ysTwKEh8vEHoFcA+3O8vwMd2+UeHgXbYEi3+z+v54agltremXDtPpZ33WMJ3+c/zknHkGNHuw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkOj7UpCLf1jbmrO6GsggUM4ipSvPv3LTW8cU2BJxv8=;
 b=bHNRXY2/Hj83plg/R/uAoOzQGRB/MI1Z5k07xvrm28O5So+gO1ghStZqRCbJ+oOLE9TgDx1WhKV+KzoDV/7wuW4RotTznyzXQGYpUtr9ozvibRA0DzcXT1a22v8ryX5FASJsfXdVJZWAa32Z5zUPYTuQmalqmF/hW9OHie86IgLz/bEu8HOsy0w9duANUJ4Om7UUJ32IPpNrxHXqJkNReus1p6ZhoR+/I5aH2Ix2J9DDCkYOv8VqwShw+Zq+5iutz9Z7JisTnjhj3mRhK7wfy/uA7BQ5wxu2tYNP6MRXthlX5f6sQZ0A56AlmHj4tyCREqwzbAWmku2+B6qem3sYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkOj7UpCLf1jbmrO6GsggUM4ipSvPv3LTW8cU2BJxv8=;
 b=UPfJbvZcEOn5/99KAM5mvxShFBqfirOzsC8+JzWngh3qp/J8GI8mS2yC7jdvALfIJrZ7OePkQV5mkVKbbybqtd2EEJ/k+jgKpG+4S2fPvp/AbVR5GslXpIMylRKq+ZGE3Y/+h7CRv0ujAtpMsiZKivHxCjhRjXXrJeNvUtzjmY0XLDl31NvTwI0njIotuw28RLjFTlGwfO7sh1xdzIkce4KnD7kI5T2E9TR8rTCVwF8Y9Q+2TkUzdC9LnPuHqETKe+5D77lZ1dHW8T456MkXCAWuiFiek/7LNS+xsZ3d5oF0qfA+YCPTwOq5iU7cMNN7ewwY59U74u5igba7oYfbvA==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by CH3PR11MB8589.namprd11.prod.outlook.com (2603:10b6:610:1ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 16:48:34 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 16:48:33 +0000
From: <Woojung.Huh@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>, <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <horms@kernel.org>,
	<Tristram.Ha@microchip.com>, <Arun.Ramadoss@microchip.com>
Subject: RE: [PATCH net v5 4/4] net: dsa: microchip: monitor potential faults
 in half-duplex mode
Thread-Topic: [PATCH net v5 4/4] net: dsa: microchip: monitor potential faults
 in half-duplex mode
Thread-Index: AQHatmDwofX7RxVygUaBCwbq0JFMQLG3y/AA
Date: Tue, 4 Jun 2024 16:48:33 +0000
Message-ID: <BL0PR11MB29138761B3109CA1878A753CE7F82@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240604092304.314636-5-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240604092304.314636-5-enguerrand.de-ribaucourt@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|CH3PR11MB8589:EE_
x-ms-office365-filtering-correlation-id: 823841da-59d4-4f19-8714-08dc84b62c19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?2wNreDEu7BVHCwqxLgswA7uWBXVeu8MwFlyBR/mk8vM3aABY0MgNMjmAKMP5?=
 =?us-ascii?Q?wPGTLVqPra57fQbFFlE6n3AEjMhKDUeSX8dOuOnF7/CDLWy39MDov6sMeH3V?=
 =?us-ascii?Q?D7g6kdGeBXMCBPw4gYmZ76iFPHsdD4P/5l/uUuJtQ0JC/xxAX0+/dTwwNFvq?=
 =?us-ascii?Q?XGl6g/7drzpTGt7HoK0KSlmRcjbSeEjTAFHBKe8mlN9mCpjSpra248f0k/3B?=
 =?us-ascii?Q?Rflv5yoYlSjIeIkEmuKmjK+DEL0P+pfxERg4R6uLU7jmQuSLe9jgHJ+k7DfD?=
 =?us-ascii?Q?cLYbtn9JHJWc6hf7Hpss5KWfS1Zgj/g1eYoJUF/5KbY9T9lE9h9hLH0NLjvV?=
 =?us-ascii?Q?AARIEXQn/xMA6cw7ZaRpJdOwtLn+1O1F+r5iyYDiwAXmcEz7EhIhWgBQf0Fk?=
 =?us-ascii?Q?agjC8DOJDxWyOQPfm/9Y7T37EFHEb2UnRgAL2H1WGuiymE5gToPOLNjBMviH?=
 =?us-ascii?Q?KoQ2Ah/yMF1PZ0QPdbH27f9e5GNF1rfqEp2fzchrCCIdBWBbslHdHFAI/mNh?=
 =?us-ascii?Q?9AxsG697Ud1JyvkylisynW+dyrNCDwaGsP1qljZH4a49oCdanttBm/Y1yDkg?=
 =?us-ascii?Q?+bg3NcxodTxaaAGJs8+tFSfLNdMgbl+8K2i15SjMp1ilvPamP5aZ82n1t34A?=
 =?us-ascii?Q?HQMge0nVh9opwpFQ8CKlZMkFW9BfurXP5nIeklkw5t9uG4wzGvIPR89FDkTd?=
 =?us-ascii?Q?oIp962+9NVWqdMReKQ46KN3vOtRvWP/1/ASe2rrUpdjO+2G6g6Gjw/foBm07?=
 =?us-ascii?Q?xxO9QyRNVf7Gmg6k1uRUqXnV89E94LCGDNqM/aXx/DCBJGXswapYnizqxB/P?=
 =?us-ascii?Q?RwhU8rlrwH572oRiuVyjuVSG0hRC4FQd2I/upQCqUCtjJSEioE05KsjTQpMO?=
 =?us-ascii?Q?VhknfqVEwnW7PMWc5n0Qcm/QgZsCItViMGyUZxEogbyzyRZtMtD3rJn0mZAM?=
 =?us-ascii?Q?43MwgaHlO5jfq+Gs9/DNoItjy1vOvWdNKGIPppPaTxzbBoK5YpHulGPxHnys?=
 =?us-ascii?Q?V2pH8e262Twei3V1J3641WLZxWFNR6UdfnQHNIz7iqetofPsmGjV4GDOQkuE?=
 =?us-ascii?Q?tW4ewUvfc+J5jEMorCsMz/uU9cUJcmnNOytD674V3KDJEAzsJooN9fV4yazM?=
 =?us-ascii?Q?fMxdwwlO3dKGP2wh5eTOrXfZkuo+3NRmk0sfygp0SLl47pk953ALBhkFKRWi?=
 =?us-ascii?Q?NgzBT+OZsS0kdhKS+htsZBAVulgzmT/lkEQQQD/qtIDNwqZ5vHW6iEQPhnwm?=
 =?us-ascii?Q?KqzXhh704gjhETNPVpcEHcKwN1Qtkf0f3ZlB/l9le181FWGGcmcQxjKe/4cx?=
 =?us-ascii?Q?XyOnOBI/G7LlFxvs7A13XhL4zfU/mWIOdQCELWOgwLcVfM4p1JVnTAxKyvaq?=
 =?us-ascii?Q?Ws/kPuc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MFYZQ/S27X1eTPUqlVmWL0+LlI6v7hOE0v2hs14ZC0ETAQWm51bDMNyeWSoi?=
 =?us-ascii?Q?LaoXktmaggvOtn/dVphN4iFoknckgh2lmi/duvf5AhMmAlyrylQ6HNIY0bwX?=
 =?us-ascii?Q?mNcblX6lfZ6seTKZy39yPlsfNP8J6KCuSeh3Da9VUJ0iaUYWyVdXbLBGTT/k?=
 =?us-ascii?Q?zkGHhCEcO9lMAIH6CeFKR76bgEmSYd/L2Y92VdBgoaDfNZ/vneJHRze+SSBH?=
 =?us-ascii?Q?+AxAP+hCXRTlhlYUoDCcC4gc0s2dFv9Mg9JNCOdh5p3i7amh2Ka8G8/0N/Un?=
 =?us-ascii?Q?l2wxXZhTgF6uRVyiSFs7kNVhPxKQyeYIYPCfkQllWOmhxRcPKzjZ05I0fGZm?=
 =?us-ascii?Q?EQ8mWhftLRWJt4Enl88mqS2IbJ8+3I+H53qknSXReO5M1pwq4m+v3IS3C3Ff?=
 =?us-ascii?Q?XZnyF3vpDT7Xgs/kptFtPKzTjVN3mX/ThZvTM47lB9KHsCC2aKWWiMtM7QoS?=
 =?us-ascii?Q?sFllOeQRlWjpg3NpSFKebZ7H/3mgBYlRIJIiE6t4fqgvGiyEcJxxWODjyaTf?=
 =?us-ascii?Q?AXMSgRiszSrZsIsCxn0eymvMieNqM451RhgGYwH/NaGcHxmWLuP2nXiFhsb3?=
 =?us-ascii?Q?F29LkLHKfIufHb2oa/14UgG/uTX3r9NWi6KNtcmp1z13mN8JQXOYOzuzE7nW?=
 =?us-ascii?Q?w8hVUCdq0XPFD3rgzYdIT+qFeVQ9tmpP0UtpT/yFfLl7OHcGTU1FlR/9VIN8?=
 =?us-ascii?Q?qzYy0JSLcfcbG/j3U+LRVTi78jzLanwiLaf4OoQnXeGmv5kWxewpLawhnObB?=
 =?us-ascii?Q?Ug5t7+IDMGUvdMk76PqeobgbtQxEgkoooMHLbJdR2H3UcdDfY4CxSLr+ZTIg?=
 =?us-ascii?Q?CtkJ+ot7ozuVPyEeO0LNJElY2FvzaHr74sCn5ApF0NPURyx2VzXaqT2n0eNV?=
 =?us-ascii?Q?RFyuRDnTgHiD6lSSIGVE9NwUwVUbDRJy4EoPTiwxP1SviANbVdBdV7PEB9fj?=
 =?us-ascii?Q?TfWSBk3G1pvma4wvxrTEw/o6PpXY4E/Rlw40V9JMbzeMmjnhQNZOqRiQMeBe?=
 =?us-ascii?Q?5tWwITnsu1cJ+gZsjTf5cUqCsymaAP2x3khS6llOhch+BWpqvh/3o48aPZ7b?=
 =?us-ascii?Q?RQ454ECeP5Y5/Cv6KKzJiDj6WJZYzwrv08aJ8cElHbTsdCbPWFtdFMMr2m94?=
 =?us-ascii?Q?NKxiXfR1tOvKiSuUyr0iatQFEItrnvGY17W4BWrjZ8JT7hl88H3F1abU9FGr?=
 =?us-ascii?Q?uY71lxpNVOOBCpMLasSyruhhsc+DlXoHYEx8vdPrB6/0u1hyo2KwSNWI4agv?=
 =?us-ascii?Q?Zyztpa2H7+14nYDd/PFs+AyQjA8SxYIqelczCMNRqMarzYiOdIOE68sZ99EE?=
 =?us-ascii?Q?to2oe32+3LkS5wlgNBHNG0xnJXk4v/M4mUfhSKYIn5aWiVJwVj6nr88IqPrc?=
 =?us-ascii?Q?9eDPnXQh/fQwL7yu9Iq+ROCnfHaWkv0PMFczkyUmsCP03VjqEm2PesKzzv5e?=
 =?us-ascii?Q?l8k82oBQph7e0sSMEZYdhQotnmxZ6Ug+tQKskqW36+6u6ed2/5iOGeMB/+hc?=
 =?us-ascii?Q?aFwbci7onHvYJbORgL3434+Esy1CR59eY5tsC6H/S2dx7o0/h/K4E127V5m8?=
 =?us-ascii?Q?0WKKNBISvFrVfM3Hgf8dM/ooZWcp/NIW7867O1PV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823841da-59d4-4f19-8714-08dc84b62c19
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 16:48:33.8122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VxFY9tWvbFNLRPoT8ptiQDXATDkJKyrfvbvOI+MkYwTrBKysDCSKXEFlVQc9JzSB1e82viHDP/9sH6uYqZOqIWs6itCelUCVKMB/BVE9mco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8589

Hi Enguerrand,

Looks you are covering Module 17 & 23 in Errata[1].

[1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductD=
ocuments/Errata/KSZ9477S-Errata-DS80000754.pdf

> The errata DS80000754 recommends monitoring potential faults in
> half-duplex mode for the KSZ9477 family.
>=20
> half-duplex is not very common so I just added a critical message
> when the fault conditions are detected. The switch can be expected
> to be unable to communicate anymore in these states and a software
> reset of the switch would be required which I did not implement.
>=20
> Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-
> ribaucourt@savoirfairelinux.com>
...
> +int ksz9477_errata_monitor(struct ksz_device *dev, int port,
> +                          u64 tx_late_col)
> +{
> +       u32 pmavbc;
> +       u8 status;
> +       u16 pqm;
> +       int ret;
> +
> +       ret =3D ksz_pread8(dev, port, REG_PORT_STATUS_0, &status);
> +       if (ret)
> +               return ret;
> +       if (!((status & PORT_INTF_SPEED_MASK) =3D=3D PORT_INTF_SPEED_MASK=
) &&
> +           !(status & PORT_INTF_FULL_DUPLEX)) {
> +               dev_warn_once(dev->dev,
> +                             "Half-duplex detected on port %d, transmiss=
ion
> halt may occur\n",
> +                             port);
> +               /* Errata DS80000754 recommends monitoring potential faul=
ts
> in
> +                * half-duplex mode. The switch might not be able to
> communicate anymore
> +                * in these states.
> +                */
> +               if (tx_late_col !=3D 0) {
> +                       /* Transmission halt with late collisions */
> +                       dev_crit_ratelimited(dev->dev,
> +                                            "TX late collisions detected=
,
> transmission may be halted on port %d\n",
> +                                            port);
> +               }

This covers method 1 of Module 18.

Even though MIB read is not high bandwidth (every 30sec) work,
however, still looping over all ports.
Can you tighten condition for Method 2 because it happens
when both half-duplex and VLAN are enabled?

Adding condition such as=20
	ret =3D ksz_read8(dev, REG_SW_LUE_CTRL_0, &status)
	if (status & SW_VLAN_ENABLE) {
	....
	}

> +               ret =3D ksz_pread16(dev, port, REG_PORT_QM_TX_CNT_0__4, &=
pqm);
> +               if (ret)
> +                       return ret;
> +               ret =3D ksz_read32(dev, REG_PMAVBC, &pmavbc);
> +               if (ret)
> +                       return ret;
> +               if ((FIELD_GET(PMAVBC_MASK, pmavbc) <=3D PMAVBC_MIN) ||
> +                   (FIELD_GET(PORT_QM_TX_CNT_M, pqm) >=3D PORT_QM_TX_CNT=
_MAX))
> {
> +                       /* Transmission halt with Half-Duplex and VLAN */
> +                       dev_crit_ratelimited(dev->dev,
> +                                            "resources out of limits,
> transmission may be halted\n");
> +               }
> +       }
> +       return ret;
> +}
> +

Thanks
Woojung

