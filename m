Return-Path: <netdev+bounces-93857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7138BD670
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 22:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7261C20370
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 20:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987EE15B557;
	Mon,  6 May 2024 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UqaSXMqN";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KyVcTYci"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82A956B76;
	Mon,  6 May 2024 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028293; cv=fail; b=uu0kwExy5pwMmwgaLNNYuIy3PPxvCdt4Gh59JIOYkqu6194qIQz9fpd+PcV7Cwmz9K5Xd+Yv2zlKXU7y9SOG/hv3wpXfIbKznxh8RQ4boqDm0ZNoxmTQmJnJLcW2Ughb6rZyfpSdszEcu7VJa7SC3pId4eUVBIqrCBWtQ59uc3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028293; c=relaxed/simple;
	bh=lH+5lUrgW8QmCZsPKaNxYhZmigICpQBL0m5UVe2gQYQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m02SruuktN3MgKFg+wl1AkHMT3ytvEDWUdLSYVvr7urGoz3bSrJ8TteeOk+IWjqAiyy3do2iQkJHxAL6geOVQ5sTTN5IkH1A1fWRsZAF+fXPW8vpDld+zBTDNN04wephAlC4/co21S2iJPH77eqf9b4eEnMpOnrlqZ0XNCJAAhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UqaSXMqN; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KyVcTYci; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715028291; x=1746564291;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lH+5lUrgW8QmCZsPKaNxYhZmigICpQBL0m5UVe2gQYQ=;
  b=UqaSXMqNh+Fm9GnrdravIve9oQS0292Rp82eTxO2Mgg1CXtBi/kq/96T
   HpfNmCSWm2sqdPajDJ3X7u22PND6UflECmj5OkXNz2vs2yw2bkKSlM2fx
   /Am29yYFKMmfhL8Z7LmnQT5tHvSxwOFl9lc4WkatW1NWCNg1aBibXuqtZ
   +oO/oRFZDWtZh3vHSH4ZRDh2Iu1nnRVV3UoIQ/9tIatcAzW4tGb0v0kQ7
   DOjbtcWijhy+4I/SqqFFOU++EPTFKXL9Wab/mjgN1hthKoyC25pJj0DVF
   vQuxfHSM2Ji1GwE8mwOFSdd3etSK8bY3th1WFq4ehiBuFsSyVbIpKNMaz
   A==;
X-CSE-ConnectionGUID: xkAkh6HmTbWVScTMWqF7VQ==
X-CSE-MsgGUID: axniiiSdSX2ibwpataC34A==
X-IronPort-AV: E=Sophos;i="6.07,259,1708412400"; 
   d="scan'208";a="26042453"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2024 13:44:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 13:44:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 13:44:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLXn7/a3p9eevJajV8MLNWOfXeBIKgkoGgE6SnVLIL83docXnGRxQ4Yi49VWRIJAZptclmUIJgHANFZ/NFEKKjIZLxIPrR05woCFFZxSFdMQZBVvDxkY5brfsSCLeMLLpvGu3z3f3Nliux1LaTKG9ukQRBfJzEVWpx3om/a+pjkjxvSt/HffUvsFy/fJJE9BQHUgwD1nJU3SXgtn3b9Yk43+eiEIrWeNQtTVOGIQBx65/npw1NGzLcWE82sWh3+33iv1/dhiBpOpHC87GJQ97zfMOlEVn39OwZi6e5EmhhbzEofbRx4JD1RTXn7f/GEM3jXpxY3FRtcM4TO9mvLjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lH+5lUrgW8QmCZsPKaNxYhZmigICpQBL0m5UVe2gQYQ=;
 b=Ldsok9mZUPgHdcXXZ7jkoqli/k5fUZ+3/qnL3gK5fKDyTivEmBdEpuNEoaAJ/Uwg7RkiDOzODIWwukJwQDD1TOSJxb8ty8oKkRdmqrhKho5Mlb0hsMrc31dIN3LWURPKF7+YURM0zpTglovcVIH8TgjY0q882h2v3KkqYnejHGs+/j8+bKvS7UK9XTyrA1t1q+4cMCP0kZTGpvIwow8jdHl5lVn6eYJUMgLBhrEZfdyM12gP72d6VXDXHdnFVyMP7+L7png+PXcE70YfaXEVzhJ/sBvDwVKJGLheR/y9dWdrw+gzOmbl7AE531fotL8skiaEhYC0gxWJhLDNjlTeyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH+5lUrgW8QmCZsPKaNxYhZmigICpQBL0m5UVe2gQYQ=;
 b=KyVcTYciNbaTJ3I/MpqEladrC5CtQbLxp45c1ws9BvZdhO1ojJ2Dyp+KSYKm/8dsLu0qU+/A6EeNFT1do7XdC4p38PZAxMwPDOeBTDvrtS+I7RVOrAiJLcNydzJm2QfTVGAiJ/xFQ5K0slPFPP/lDPl3OYBXXqKJ6Z84dwFBc11COr4ECvdhcX17Iy4YFeqrE8mdvUhvuKR0YI3g9T87j37e4ZyPL3XN/Gnw93NDQqmvdt1ltt4XNlxB4chnOIIzVHk09kzA5bH43o3Ex7xV0GU76EbTzMg8PoooJnBX96WcG3cecA/4J9JpCuC0Oz7+YTLmAhhCLEu6J2nlNHiiQw==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by PH7PR11MB7026.namprd11.prod.outlook.com (2603:10b6:510:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 20:43:55 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 20:43:48 +0000
From: <Woojung.Huh@microchip.com>
To: <o.rempel@pengutronix.de>, <davem@davemloft.net>, <andrew@lunn.ch>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <olteanv@gmail.com>, <Arun.Ramadoss@microchip.com>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<dsahern@kernel.org>, <horms@kernel.org>, <willemb@google.com>, <san@skov.dk>
Subject: RE: [PATCH net-next v7 02/12] net: dsa: microchip: add IPV
 information support
Thread-Topic: [PATCH net-next v7 02/12] net: dsa: microchip: add IPV
 information support
Thread-Index: AQHanVvYOrS/w3MF/UCWVV5PJclUi7GKpGpQ
Date: Mon, 6 May 2024 20:43:48 +0000
Message-ID: <BL0PR11MB29131C40E4B39B119F9891C2E71C2@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240503131351.1969097-1-o.rempel@pengutronix.de>
 <20240503131351.1969097-3-o.rempel@pengutronix.de>
In-Reply-To: <20240503131351.1969097-3-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|PH7PR11MB7026:EE_
x-ms-office365-filtering-correlation-id: e025bd0f-8a8c-4d56-0861-08dc6e0d3b4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?po3Ckx6yw31sfTetOyAf5XuMKXUxmD7C8Q20MusnoWUas+XwJwvjELjwCP?=
 =?iso-8859-1?Q?163oMzZlelU+2zewU74ml25Rrc2p5frmMFpKYC2x6FEkPGrlAtPDlTyo6F?=
 =?iso-8859-1?Q?tU3Yme6yJkMPhPk4kwyn5ZuM12tdxi1KOJJIhLQng7ADEEiWRXBlVY/gsd?=
 =?iso-8859-1?Q?WTB6tK4QTqt1paxFXUiB6BIzLhPf47JB9gdiPOWtcj0W12FeLoHJpIQosK?=
 =?iso-8859-1?Q?Rgt0sTDsPpE3FXnZ58I7GhZWGkSqv9xvbjMBwROSWjFO+1ZhnlYNCIgZx3?=
 =?iso-8859-1?Q?1oyZKzqQ+bTXb+XGrmFtpTPxUXWtakahCszOF5wOfFudPk9Bg8lWBYz9MW?=
 =?iso-8859-1?Q?kQwE/y+vjMuwUQIYy/NqGVkHFHX17vPTDiErUn7HuCObQcGwOPN0lAKlJ6?=
 =?iso-8859-1?Q?Wcqp9nP4H0t48fRhniSoIQSngPhpDibCReFwigOloLgz2vbzky3gzZs1+1?=
 =?iso-8859-1?Q?f0dhjarg2wYISixAh0XE9cKZI8HnEIgmgb2aOR3xkdvng53y/Nq3FLvWbr?=
 =?iso-8859-1?Q?yzVAWtcLzKrHR5ZScb4/LuJfaq7l1yHSXBBUynUMgs7ZNZQ/H8LBds3fMx?=
 =?iso-8859-1?Q?t5RRTLz4lCFW3xTnu/cytTHE+Vmz1ssOBTAD/qZfu8K0Jsf6eu3PTRKM7e?=
 =?iso-8859-1?Q?RluwNpBkKha+x6+LqcKWkEGVwr4ySxvDLDF2LVpqtA3VM6lxYDDj8Z8Ufo?=
 =?iso-8859-1?Q?RsIndFagwq0ePR3fQvmg60kJJcFP+7GsoSL2LYTeS49Y0YxtK4yjZPZPwM?=
 =?iso-8859-1?Q?8cV7kHGkbRwZhehGZzb3945Z07euKpck0O0ZtZjUOc2M+QyUj8xpLidgGk?=
 =?iso-8859-1?Q?lUDbslmCMgiqNEE+TljpeWStdYH2bGghtQ0jfcN7kx9ylXHKG8qZ4Qdkz+?=
 =?iso-8859-1?Q?gFGcIEudUuA5UZAfuithtR93Tb9KtnkrU9/AOTODGJTECXd7SuKI/hM+f/?=
 =?iso-8859-1?Q?0CwanByIrzX3DO9uehczDYGSpsFbWQvjeB/VlDkzOpjAHy5FHQzy5u10E7?=
 =?iso-8859-1?Q?XI/ESL5Brb+WsTfG36IMo2qvc3HjkDAxtQu2tnSUfZebnNCyxlHbiB3jO5?=
 =?iso-8859-1?Q?qtGvACwq9noazG4Jb22TEUXbeq/JWnHDeekm7QSdO7oc17DYHV0yUdFhBj?=
 =?iso-8859-1?Q?BT0Gl/10ElN2ZBDSWcKNcrEQhH+Bsg2XYIZO7IMwCbPWo14KSoNndqI9Sm?=
 =?iso-8859-1?Q?ndZu/GR+9DUyUe6NE28TA0IiXqkTbClRVbc1aiDG7hRbgE66nFQDWB+peW?=
 =?iso-8859-1?Q?Ah4f+g5SJrjnDCHPSEqFmb5HraE37H2wQ+255SwFaSgn0tYs4fXED2KX1U?=
 =?iso-8859-1?Q?jnjZYS+7Z1nOFrGffq/d4fl3sQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZixoYwVfCUYYxtS2ZzdeDBI89MnwrgsYhrxfL/V4N6d5XPCh5/ADdWq1IL?=
 =?iso-8859-1?Q?4pdR9t5aCpMk+FaakdYmCYmnW1Yl0TYYLLmC5UhLkwP3CJkg8pJMzDzdBL?=
 =?iso-8859-1?Q?Ru9vWaDH/utLqPorQ405Am/wiLyajto9C7wQqS+hsiX4SpiIj/TsVUWufu?=
 =?iso-8859-1?Q?YAQ9IYEEN6oGu0U4dnqfQyK5Smxk/Sg8YI8CbkhQ/OJYSDJE+y4B7HJM1j?=
 =?iso-8859-1?Q?qGXdpjVysyQ/USf9GP5JTwWCU2/c3Wua+eWIbJbE4UKtj6pkKjvYMyMWcs?=
 =?iso-8859-1?Q?WF6oH89JhLhcRP1ki9cK/pB2t+XZuddK1vHC+l67+S9HKuFjzxaPpqSNnM?=
 =?iso-8859-1?Q?dbIbBH6AdiG4P288qmnebfjsUbqGTGN5ghDaZW6OHiajIHl3zF4iJEIL+3?=
 =?iso-8859-1?Q?IGUTe4Utmd36QpY5S5S4X0VGwtdHk2yGsihks4b5GNeI+Dt6Z57txyfrgS?=
 =?iso-8859-1?Q?DDhsFsUfFTrAfYKDvKVq51//YOyf2HxX1p542qnMOoFoH4a76alL4G1fDs?=
 =?iso-8859-1?Q?pm0dRjI0TA2HDT7aBjpo+B8vRtLN3k+N9gx92UB0I7EWtt5gRwaF+wmhbU?=
 =?iso-8859-1?Q?U/TQPxaLYfmpAWtxSVogiTmvAAfkX1c7JmOY7FY3hcBkIy2ihb23bc8ImJ?=
 =?iso-8859-1?Q?jVWEHP6TB+mmkhk1if2vYYBkZM68Z5Pd2souM8/TcinkzQYyRjM9soLseT?=
 =?iso-8859-1?Q?nCKQeljjwijfuYTB63hnAbEgQZeBizbigBox7ZvcCvkpOIGpPCuEPHjUhc?=
 =?iso-8859-1?Q?za9aOiocRQXGvNZ/Q7wHZSqM9kc3oZRxSgd19pZCrDwTKIlaygfCdbs+5+?=
 =?iso-8859-1?Q?1YP9k7ILbOrVmKKgQ9G5bezXQSE3hmhszRlIitrWLZOXGlLLzFcaSZC7gq?=
 =?iso-8859-1?Q?ol5tvZP1wUbsM7+YWI779mZ8+urhMECG51sPDgMEOIV4DVgUfCkyJjzel0?=
 =?iso-8859-1?Q?UPB+gKwO+bAKWdpi70k7N0UNF00GdVV/gGEoaMlC/brHjziKZhbJxb+fMu?=
 =?iso-8859-1?Q?a+EqiBb4dCa0d1nC0LHaw9Wx9kS4TO6CiOKwiSTEO+162HiKIKF6iX3Q0I?=
 =?iso-8859-1?Q?nwvs7E+cwvFMI3kl3Ol2R8m5MwTzUn8IVS53VhJSDLWEQdDRm/4pksrh/r?=
 =?iso-8859-1?Q?ZmNEBlh074OoQw9XUzz47XCgpWtxLvCn0tFkwK3ov1n8AEk9aS1u4TPOCP?=
 =?iso-8859-1?Q?WdQ0l4YsSWBJ/G0FzW4eL7U8LYOERTERpkzTCIc6y+sJpMuXNg0NmBZAy8?=
 =?iso-8859-1?Q?QI0W3pivBejF2r14wUIzKwyz932GGW667IsgJctkfCDo2qsowG+oTlSo1d?=
 =?iso-8859-1?Q?LHZiAI65fV1yeiK6C/epfXw9TZMaiN6rFpSe+/UkXpu/OP1HLDfppOpUXk?=
 =?iso-8859-1?Q?zgS26r3XG8TmowA/QT+GQJ9TpucNAmg5LglIwuSyNWSYs3LUEIKMn83y7b?=
 =?iso-8859-1?Q?l8tRX37kFgoCDEddI5/ub/JG5st3tmC03TypxBOzz5lYOZ9lb28zSIX3An?=
 =?iso-8859-1?Q?L8tIMSKeqrz4ABmJMzURxSbJgkrJUoXhuinzl75dY7SJOuKui8lsrRNHm6?=
 =?iso-8859-1?Q?jZKJv0lG4SUh/dh5I9WHJRk6srs2MvmJxQH1n8509ofi8ktBbB/Jv7seZQ?=
 =?iso-8859-1?Q?hKmyXkHWfI8hjveUKYfsaSsQVpQeOIGoqP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e025bd0f-8a8c-4d56-0861-08dc6e0d3b4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 20:43:48.7817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XR+iNr0pf1xRN+awq7I1LTAzX2RPqHpqT3ny4Dds7EUEvyb/j6IZszSB39t1tIOaNPgvxbQXaBOdigTAMLEkY05te0YO3/ahlTIk8SO8x8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7026

Hi Oleksij,

Thanks for the patch and sorry about late comment on this.

I have a comment on the name of IPV (Internal Priority Value)
IPV is added and used term in 802.1Qci PSFP
(https://ieeexplore.ieee.org/document/8064221) and, merged into 802.1Q (fro=
m 802.1Q-2018)
for another functions.=20

Even it does similar operation holding temporal priority value internally (=
as it is named),
because KSZ datasheet doesn't use the term of IPV (Internal Priority Value)=
 and
avoiding any confusion later when PSFP is in the Linux world,
I would like to recommend a different name such as IPM (Internal Priority M=
apping) than IPV.

How do you think?

Best regards,
Woojung


> Most of Microchip KSZ switches use Internal Priority Value associated
> with every frame. For example, it is possible to map any VLAN PCP or
> DSCP value to IPV and at the end, map IPV to a queue.
>=20
> Since amount of IPVs is not equal to amount of queues, add this
> information and make use of it in some functions.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> ---
> changes v3:
> - rename max_ipvs to num_ipvs
> - drop comparison of num_tx_queues and num_ipvs. It makes no much sense.
> ---


