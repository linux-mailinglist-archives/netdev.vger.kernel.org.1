Return-Path: <netdev+bounces-305358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mRFGBGPCTGobpQEAu9opvQ
	(envelope-from <netdev+bounces-305358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:09:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9790F7198A2
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:09:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=FNouLKNa;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305358-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305358-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2D7F308127B
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC7F38E8B7;
	Tue,  7 Jul 2026 09:06:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC523394B
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:06:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415167; cv=fail; b=AcBnpnTzWk6MdpK7M6v7q6OtOZkeVLjes2l/8BalVjq2v0IvKIW2OHIH0iGqhKVHYDFbuvwT0bkqGoqCoqYmo+6Tw3b69RtRm3Op99lLNPk0GttJgZBEjBCEAC5KwTRCY6qqjbXk/Hewgt0Bo9R/2BFCfEu+76dia5es+USbWjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415167; c=relaxed/simple;
	bh=11l19zxCWoHMbx4aMHQ00o81MlyWE9W9mhLSzLbjMTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uAO6KxuC1tRFTRhWWVL68d58De0S/2NpjfnHkRR++WvEYMBbBJyliuT89FDjD4sXGxIeJokzEZwLQwFeS2pfHN/4+VtnHtT26H3MZaQsUdr1VyDZiEDkIPCUpSCHDQ6Li0J/RmT4fEuqUmGvNx/Kywdk58Gl8RdsF3PosczTuE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FNouLKNa; arc=fail smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783415165; x=1814951165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=11l19zxCWoHMbx4aMHQ00o81MlyWE9W9mhLSzLbjMTE=;
  b=FNouLKNaWy/npHH5OgYdjVteXCuLocnUT9C8/ppfrj6Qiw46nCV/jC/E
   prjV8e7E4fsCkxM+WFkU23WArNsQ5RmPpfdt1xCH7ApfepHJcg655jC/Y
   nxnOaz6ZZgTIiZEu/CRhEpRwTmufEmAymoty2QN+G0eG92e9BkgCCj8JE
   YNJXTSNH5PtKr42fs4enPkkZEZgsIMf+QP4AlvPpA32PkAU+XcZLj1G8I
   jLDxsM/BRscbgHv8DPNIBRhTUmN5UnxI+ruQ7qoQef/UY9KGdtWrLSoUe
   /xEe8Bx9lTRT8448mmi5m49OK7g7v0cX+6hS55xb5FqhJdmpF7DGcLH//
   Q==;
X-CSE-ConnectionGUID: 4aD7f98LQtOl+hVVB634Gw==
X-CSE-MsgGUID: RRREe+5YRImHoxt8EXRmRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="95436520"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95436520"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 02:06:05 -0700
X-CSE-ConnectionGUID: UpayF3mOQTuWd9TULqlvdg==
X-CSE-MsgGUID: 9H/+TPWOQSa3s7bVkziicg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277158190"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 02:06:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 02:06:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 02:06:04 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 02:06:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwQV9UHF1vXHU3Uq8uNYeFkBxkf8v0aeMRZtMlnkHDlPDu/b/D0mV5P1McCK17ZOGLu3cZlV5do73GklbBaPVwbYTkVEVSknriahsBdtarTsmfNWHS84VntuBdnDTicYfpKj+fk4FtqVgIRQHKeASURi6mC3xzTYM7J9ZTnuY/ATxLXlrm5ftOgmS5hPhlIO6T8n+fHjmO9Lxu//caiBbvZa+C8zQsttdCleSWfVp+68pg5wiEPPj+ksCgQOFyB4B9KQ0wXiZbX9IRd6AoN/MnOaHaHqBrVVwphDpfmle8bGiwiPu7SAbysiHdV+5OQVf92kmiRPxUr9RvtsH3ebEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Icu5AdgWSyR4Mgj3q2DhyhxARgFjRiXmTNw8sur3D1E=;
 b=G455DQoVfbvvY+tc6la344PnzWh4hpf2eobvScHF+v1qWZC2KAqEzCm+uJiayWqZ63V6qxPY+QHjrfU2xJ5FdD8/qGJG/wYGNQtNirOecuMDXlhWpndMcdMx4TlwfeCumZLi+587Ope+T0JfCcGHlE8iHopOXHntLCmfdzPfJuVTU1pCtQwi8Aq4Ds2YyKIyMkHsRx7JaUlGMaMRsVIiY3TyMCROtVVgO7/oheZO1dLMjP2V1r+Ll5h3grE/6dgZ2Knm8b1049fFVMIkJ6g63hwXVVWsc0q4z+Wga6CrKQYAJ4EhRTPOYcDzCv8cSEsrxtUn4iI6+JABqk3GninnLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 by MN0PR11MB6111.namprd11.prod.outlook.com (2603:10b6:208:3cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 09:06:00 +0000
Received: from SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde]) by SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde%2]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 09:06:00 +0000
From: "Das, Shubham" <shubham.das@intel.com>
To: "Srinivasan, Vijay" <vijay.srinivasan@intel.com>, Lee Trager
	<lee@trager.us>, Andrew Lunn <andrew@lunn.ch>
CC: Alexander Duyck <alexander.duyck@gmail.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "mkubecek@suse.cz" <mkubecek@suse.cz>, "D H,
 Siddaraju" <siddaraju.dh@intel.com>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Lindberg, Magnus"
	<magnus.k.lindberg@ericsson.com>, "niklas.damberg@ericsson.com"
	<niklas.damberg@ericsson.com>, "Wirandi, Jonas" <jonas.wirandi@ericsson.com>
Subject: RE: Ethtool : PRBS feature
Thread-Topic: Ethtool : PRBS feature
Thread-Index: Adz5hWg21MQs/VUaTJGfYpUI2lYKsQAM6bGAAOssNkAAEWE/gACW3a0AAAT6GYAAKCJlgAAB15QAAGW4BSAAJtcogAAPdBwAABO0owAAG26fAAD6e9ZgAAPKZQAAFsd4YABPDrYAAAbkChIAAZiPgAAA8RcAAAL+94AAAJsL6wEGjQLQ
Date: Tue, 7 Jul 2026 09:06:00 +0000
Message-ID: <SN7PR11MB8109F7A3F491E20701BDC0DFFFF02@SN7PR11MB8109.namprd11.prod.outlook.com>
References: <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch>
 <08f1b0c2-2b09-4c30-b95a-02959d409a03@trager.us>
 <38359a70-ebc7-49c5-bae5-0d3d7bf82fac@lunn.ch>
 <CAKgT0Ufpp+AVrW4raMw=_PEWQdu+dkp+9xhrt1se2G7=CS83iA@mail.gmail.com>
 <SN7PR11MB810921E7DA70DB3F6FD1C41DFFE82@SN7PR11MB8109.namprd11.prod.outlook.com>
 <6e905826-779a-456d-a37d-7602a37ab6d7@lunn.ch>
 <SN7PR11MB81098D82A7B377E0AC439979FFF62@SN7PR11MB8109.namprd11.prod.outlook.com>
 <cb7921f5-cc9a-49fe-9561-cac903cf611e@lunn.ch>
 <BL3PR11MB63854B0A4AA33A718D474C6588F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <BL3PR11MB6385517EECD04C783E9DC42488F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <26d44b09-d72c-4e23-84a6-3d0ea4a521ef@lunn.ch>
 <705f6fcb-e0e2-4898-bf83-78c38f32f505@trager.us>
 <BL3PR11MB6385468A86BACA1D8EFEF2BE88F62@BL3PR11MB6385.namprd11.prod.outlook.com>
In-Reply-To: <BL3PR11MB6385468A86BACA1D8EFEF2BE88F62@BL3PR11MB6385.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8109:EE_|MN0PR11MB6111:EE_
x-ms-office365-filtering-correlation-id: 12488557-2116-40f1-01f4-08dedc06f6d0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|4143699003|6133799003|3023799007|11063799006|18002099003|56012099006|22082099003|38070700021;
x-microsoft-antispam-message-info: Bm1Sk0HZ+d3X/QNASUl6H5t4lLW0OXgqVywD8w+kUAdsPdaexjoYfnkMP6Iyo/gRkwfYFPdQxbYVzPmpFPe18Fp9AgCh2EXYyosClgzITQwfwG8FJPk2UJprzjOhxsy/NxvzsaRgkg5EWxwzVYiAne78qM9J0foOv0O7u1IHC6pPbr3CRgp/OYWL1DyOQzslx+J2ro29Gln+Qp2noJ9bOv9bigJTu5zoEpwK85x/mBJwqxgrOWJFlHX1cqnMdCb4u65axzP/twTfoHxO1EW2U++sPvBQiV73RfT+tF4IrvR5XtHJCBDFoBU7UksjFC3IPHkuf2nKw5WCPk6qHpQDKipC+vX7M6bzRwEbF13tFh4lZ6rGbLoRCpAZxGnUzVGrINg/8JjCX1QJQgdDnsppn7BwRxAMyZwG8+wE1s5IQ4QFx+SI3ztrk1doS1zbVzQwiixDKYW4CIdQwHguadgxm28sHDClCcJayg1jOw6UvHaOxodq6IFQ1yXbqJqFbFUQMJqpiR2KnPW7nJxFzX/FXtWcSij4bMFBgl2WBg2a7/zpkR2AIEm1m68xIibHin3/xlJwnEW44kyAw+xUtCjdOOQ36ljwNSJloYirPXXWUp0XSoRuv93FYSsf6ZLy1Qta1GFsMMujcyQJ9p5WDpViLiiOH1dYGDjej+IxkJgeKEx21ZB+Xx25J5XjW8ID45Qt2E8IeowaEVraNJkfdr0FwDYCMjH2y7DkqFxiaigNBio=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(4143699003)(6133799003)(3023799007)(11063799006)(18002099003)(56012099006)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+8MrJRf5VV80Ff4Sz17Wf5DlC4EZmkY0FFPd2kOHDywq0M90IrIFOcT7jR?=
 =?iso-8859-1?Q?mbA5vrJsyQF9gxNM6DOGTb23c1Xe5Gpxb10PwHo3xnGSKoGJttt3hqTUq0?=
 =?iso-8859-1?Q?hRU1bodX/8LuErnVPcuhtWv1QLKdqgLq/mznN+RkN7s826hEkBzaj7Msi9?=
 =?iso-8859-1?Q?i4CKKgYMXLknzFdC0sdftTGbaHGMWqcCuK9QikWX3SD3eGuwvdwJn6H+MI?=
 =?iso-8859-1?Q?s8w4tAbU2bB5slVXLieIso7KKgImWKMW1YQcqwrGjRM3yriVBWH/x7R2eQ?=
 =?iso-8859-1?Q?8xfpu1VatCVL1LszZkMTE6+jtelQHGSsvf1XwjXobsJgsjNpOJ9gbNuP7L?=
 =?iso-8859-1?Q?UmUUwy4IjHOGVK81zBvD4/G6WjWV6SCtnbDY3HygATIEOXlk/bOTWZ8FOe?=
 =?iso-8859-1?Q?geNMOyRev2sf/gRdraT1v49miaETkEw3KWEcpb80i7wKb09wTw9yTbkWE7?=
 =?iso-8859-1?Q?lxdtHJtlzJReP6LXlVsIx2epBjhPk2/oT4PB3l4Xqv4SYr7N+Hlicr8yet?=
 =?iso-8859-1?Q?LHQHvmovHPFHzPg9uajT4cDLoSqFr4fC7vDrYZI3o+tutPRLZcExQHMzDK?=
 =?iso-8859-1?Q?dUw0GQW5G2Lp2RHbtcTmiT70H+SMQf1H1vmhdx2UTtilfTIZ54jWkZzJMk?=
 =?iso-8859-1?Q?4yTXQ5/GLblQbIaC9KTH/AN6OcjypDUmYktriJ8pVrcljVV3qM00YvfvvZ?=
 =?iso-8859-1?Q?zA5uA35MDWGqLhAjWevWixdD1kfkvU/g3gzxMwRoe0XJW991yQ8nrOMwJg?=
 =?iso-8859-1?Q?L5YHFEKLX/WFXY4n/FKjrghnNAI/WRftbYnCvddXVY2T50pduARd4jqf12?=
 =?iso-8859-1?Q?mBs9cGOIGrEg3khAxkooNx8zvoGT2o6bX13+tx1ONRNrwpDHtvE++PzyHq?=
 =?iso-8859-1?Q?C9FlvIZZukcSmosZL4gogkLYRnoDQNBftd+RYDhLnk4YjbsIZx+o56+P+g?=
 =?iso-8859-1?Q?ckjBnXq/JacB73eDP8ePYlmMsjhHS8aWoOQxQ/mfve3fRHPJXPFOFmGW9G?=
 =?iso-8859-1?Q?kTjYInrwdnryJAfekSQTmUSn7l+SHrDduaOxRHB6p4B/p8vww1M6EV2Gza?=
 =?iso-8859-1?Q?uJiQ+nAsvh6SszDclSa86ABmajtjD+lKNHfeWy83TAoIGlVUwxqyjSMClC?=
 =?iso-8859-1?Q?4sgpACg5kUQI1bJGQvxx0pEsci0E4UGhw65bGrXcqQooxyb0hC/OTJM6/z?=
 =?iso-8859-1?Q?wYKd+aPeYvEplDcpPtw3fO3PL4nKJ5beOEPfi2XRUPFWCOFJL2Lcx2oH0C?=
 =?iso-8859-1?Q?xnpt9WtoLcSSmG4FnTHn62aPi+42utJgR19TvkK4YYTqztZA1z0EDTwddI?=
 =?iso-8859-1?Q?pcwRIZ8tyrKA8Jx9gz6/cYo4tYQ+GyaQwuTWgb0eChSA5oN9/Kg3GpAjGl?=
 =?iso-8859-1?Q?7buVMqLhYFHjPbpvvlgpXUHaeE20bBkdBH+ab8QIm8QUhcOVwxnXxQu0PK?=
 =?iso-8859-1?Q?mZ6lcRGxo9YSJj3wJwtS7zzuUY6iVTFBFBUEAGL9POjJC7WerXffVyFh2K?=
 =?iso-8859-1?Q?bD5V9/9p044HnfSSqZELC4RA+pWgTzbfWUQEy2WokWvFhKU8IDhqwHbp6M?=
 =?iso-8859-1?Q?F1sRzPwXvRw0fRfLZ4F3+bfek5ZcCPbz1ReGD6iXwxbBYNzdp7DN/zVXl5?=
 =?iso-8859-1?Q?Ieg6UNdNcAiknC7XCwDy1aFwgAArkC4sAZE6+2Mli20zsWJxed4e0dCHTr?=
 =?iso-8859-1?Q?FMlTKY3xl+4hrmaOaD1sjHpI5PY2B11fUi8UNHXnA3w+KBerCyyLhd9EJ9?=
 =?iso-8859-1?Q?kU45gn9NWtv5CTKLfcaRSWgtDBx7wk8nt/w0+Wr2ZztD+sY7t0ulOqbWAK?=
 =?iso-8859-1?Q?5AOq83TYfQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Q+SXSvf47skf2wFnIqOrnNrNsf6J/fvsVyCI9kP7FT24lDVWDwHlvakf4AW+1YOXELFwTvfN8FnpXf5yA5cO1Evo18RRvC2nU4ms6iQhwHEjH4fmAv9sJZa+1iNVM8WUBaiVx5gpLC9/CpYwiAbAMF0SizxRZIvnj56tdHmpGZe5+27PTfLfrsWj/AA5mNkrv4rEC19bLf6nlYXrj6jHdsJYtOhVFpBgNPOek0MBVvfujtiNNCHAoOuz/CfidV8rb56DP3MFtFY0HniQ1vlc0CsmSKg5WRrRRNAeivvJFvfsHA1oNz8WwI6uq+w8Xs05Gik2S4WdI+LxVeIinwIONQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12488557-2116-40f1-01f4-08dedc06f6d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 09:06:00.1840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Shm39xHUqIMYo86MbGWBXlCs357X1fDEBfyTTofNTt4LAb23BxHQFYXQUxHxpsnywfm94Uiq7ZiRlkuIpCIDzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6111
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305358-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:vijay.srinivasan@intel.com,m:lee@trager.us,m:andrew@lunn.ch,m:alexander.duyck@gmail.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:jonas.wirandi@ericsson.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[shubham.das@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,bootlin.com,vger.kernel.org,suse.cz,intel.com,ericsson.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shubham.das@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9790F7198A2

Thanks Andrew, Lee for the feedback.

Lee,
I don't see prbs11.0, prbs11.1, prbs11.2, prbs11.3, prbs13.0, prbs13.1, prb=
s13.2, prbs13.3, prbs16 and prbs32 in IEEE 802.3 2022 standard.
Is this specific to fnic based on base PRBS pattern or it is mentioned in s=
ome other standard ?

Each lane and each direction is a completely separate test with its own tes=
t of
> statistics. The test is actually verified on the Rx side, Tx is your gene=
rator so you
> won't have data to collect. So when you run PRBS testing on a 2 lane NIC =
you are
> actually running 4 independent tests.
> While its fine to have a shortcut to run the same test on all lanes we ab=
solutely
> need a way to run tests per lane and the ability to choose Rx, Tx, or bot=
h.

- Agree, we need lane parameter in commands, Updated command.


> I wouldn't consider stats a phy-test action. It shouldn't change the stat=
e of the
> NIC at all. I would just add phy-test-stats as set of standard ethtool st=
atistics.
Yes moved under separate command.

Below are the updated UAPI, data structures, and Netlink messages to suppor=
t PRBS/BERT and test pattern configuration.

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netli=
nk/specs/ethtool.yaml
index 5e9135e3774f..113005a5f80a 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -30,6 +30,35 @@ definitions:
+  -
+    name: phy-test-pattern
+    enum-name: phy-test-pattern
+    type: enum
+    name-prefix: phy-test-pattern-
+    doc: PRBS and other PHY test patterns
+    entries:
+      - off
+      - prbs7
+      - prbs9
+      - prbs11
+      - prbs13
+      - prbs15
+      - prbs23
+      - prbs31
+      - ssprq
+      - prbs13q
+      - prbs31q
+      - square8

+    name: phy-test-action
+    enum-name: phy-test-action
+    type: enum
+    name-prefix: phy-test-action-
+    doc: Actions for PHY BERT test control
+    entries:
+      - none
+      - start
+      - stop

+    name: phy-test
+    attr-cnt-name: __ethtool-a-phy-test-cnt
+    doc: |
+      PHY test configuration for pattern generation/checking,
+      BERT (Bit Error Rate Test), and statistics.
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: lane
+        type: u32
+        doc: PHY lane index to target for the test operation
+      -
+        name: tx-pattern
+        type: u32
+        doc: TX test pattern type (PRBS or square8 wave)
+        enum: phy-test-pattern
+      -
+        name: rx-pattern
+        type: u32
+        doc: RX checker pattern type (PRBS or square8 wave)
+        enum: phy-test-pattern
+      -
+        name: bert-action
+        type: u32
+        doc: BERT test start/stop
+        enum: phy-test-action
+      -
+        name: inject-error-count
+        type: u32
+        doc: |
+          Inject a specified number of bit errors into the PHY transmit da=
ta
+          stream for diagnostic verification purposes.
+
+          Context and Purpose:
+            When performing Bit Error Ratio Testing (BERT), the receiving =
side
+            runs a PRBS checker that monitors for bit errors. Before relyi=
ng
+            on a zero-error BERT result, operators need to confirm Checker
+            state and configuration to qualify result as TRUE.
+            A checker that is broken or misconfigured would also report
+            zero errors, giving a FALSE pass. Error injection provides thi=
s
+            confirmation by deliberately introducing a known number of err=
ors
+            on the transmit side and verifying they appear on the receive =
side.
+
+            Note:
+            Receiver under test maybe in the same port as the transmitter
+            (loopback mode) or a different port in the same device or anot=
her
+            device connected to the transmitting port (non-loopback mode).
+
+          Layer and Mechanism:
+            Error injection operates at the PMA/PMD boundary. This is
+            bit-level injection in the serial data stream, not frame-level=
.
+            The SerDes Built-In Self Test (BIST) block inverts the specifi=
ed
+            number of bits in the outgoing serial stream. The injection do=
es
+            not distinguish between data frames and test patterns; it
+            corrupts raw bits at the physical layer regardless of what the
+            stream carries.
+
+          Mode of Operation:
+            This command implements "one-shot" injection: a single burst o=
f
+            N bit errors injected immediately. The PHY inverts exactly N
+            consecutive bits in the serial transmit stream at the PMA/PMD
+            layer, then resumes clean transmission. No continuous/fixed-ra=
te
+            injection mode is provided.
+
+          Prerequisites:
+            - A PRBS test pattern must be active on the transmitting port
+              (tx-pattern !=3D off).
+            - The receiving port must have the matching rx-pattern configu=
red
+              and ber-lock-status must be "locked" (indicating the checker
+              has synchronized to the incoming pattern).
+            - BERT must be running on the receiving port (bert start issue=
d).
+
+              Note:
+              Availability of BIST mode test pattern generator, checker an=
d
+              lock indication is IP dependent.
+
+          Semantics:
+            - Fire-and-forget: the command completes immediately. No
+              persistent state is created. Each invocation is an independe=
nt
+              injection event.
+            - The command may be issued multiple times. Each invocation
+              injects an additional burst of errors (counts accumulate on
+              the receiver's ber-error-count across invocations).
+            - If no test pattern is active, the behaviour is
+              implementation-defined (hardware may silently ignore the
+              request or return an error).
+
+          Expected Outcome:
+            After injecting N errors on the TX port, the far-end receiver'=
s
+            ber-error-count (read via --show-phy-test) should increment by
+            exactly N (within hardware counter precision). This confirms:
+              1. The PRBS checker is locked and actively counting errors.
+              2. The data path between TX and RX is intact.
+              3. The BERT counters are functioning correctly.
+
+          Example Workflow:
+            # Configure TX pattern on port A
+            ethtool --phy-test eth1 lane 0 tx-pattern prbs31
+            # Configure RX checker on port B, start BERT
+            ethtool --phy-test eth2 lane 0 rx-pattern prbs31
+            ethtool --phy-test eth2 lane 0 bert start
+            # Verify lock
+            ethtool --show-phy-test eth2 lane 0
+            #   -> ber-lock-status: locked, ber-error-count: 0
+            # Inject 5 errors from TX side
+            ethtool --phy-test eth1 lane 0 inject-errors 5
+            # Confirm errors were detected
+            ethtool --show-phy-test eth2 lane 0
+            #   -> ber-error-count: 5
+      -
+        name: ber-lock-status
+        type: u8
+        doc: PRBS lock status (1=3Dlocked, 0=3Dnot locked)
+      -
+        name: ber-error-count
+        type: u64
+        doc: BERT bit error count
+      -
+        name: ber-total-bits-sent
+        type: u64
+        doc: BERT total bits sent
+      -
+        name: supported-test-patterns
+        type: u32
+        doc: Bitmask of supported test patterns
=20
+    -
+      name: phy-test-act
+      doc: |
+        Configure PHY test parameters. Each attribute is optional and only
+        specified attributes are applied. TX/RX patterns are set on the
+        local port. BERT and error injection operate on the receiver port.
+        Typical workflow:
+          ethtool --phy-test eth1 lane 0 tx-pattern prbs7   (TX side)
+          ethtool --phy-test eth2 lane 0 rx-pattern prbs7   (RX side)
+          ethtool --phy-test eth2 lane 0 bert start         (start BERT on=
 RX)
+          ethtool --phy-test eth1 lane 0 inject-errors 10   (inject 10 err=
ors on TX)
+          ethtool --show-phy-test eth2 lane 0               (read counters=
, expect +10)
+          ethtool --phy-test eth2 lane 0 bert stop          (stop BERT)
+
+      attribute-set: phy-test
+
+      do:
+        request:
+          attributes:
+            - header
+            - lane
+            - tx-pattern
+            - rx-pattern
+            - bert-action
+            - inject-error-count
+    -
+      name: phy-test-get
+      doc: |
+        Get PHY test configuration status, supported patterns, and BERT
+        statistics (lock status, error count, total bits).
+
+      attribute-set: phy-test
+
+      do:
+        request:
+          attributes:
+            - header
+            - lane
+        reply:
+          attributes:
+            - header
+            - lane
+            - tx-pattern
+            - rx-pattern
+            - supported-test-patterns
+            - ber-lock-status
+            - ber-error-count
+            - ber-total-bits-sent
=20
 mcast-groups:
   list:

- Shubham D

From: Srinivasan, Vijay <vijay.srinivasan@intel.com>=20
Sent: 02 July 2026 05:19
To: Lee Trager <lee@trager.us>; Andrew Lunn <andrew@lunn.ch>
Cc: Das, Shubham <shubham.das@intel.com>; Alexander Duyck <alexander.duyck@=
gmail.com>; Maxime Chevallier <maxime.chevallier@bootlin.com>; netdev@vger.=
kernel.org; mkubecek@suse.cz; D H, Siddaraju <siddaraju.dh@intel.com>; Chin=
talapalle, Balaji <balaji.chintalapalle@intel.com>; Lindberg, Magnus <magnu=
s.k.lindberg@ericsson.com>; niklas.damberg@ericsson.com; Wirandi, Jonas <jo=
nas.wirandi@ericsson.com>
Subject: Re: Ethtool : PRBS feature

All good points and noted.=A0
Will write the specification in general terms with full description of cont=
ext, usage, configuration, expected outcome etc.

Vijay

________________________________________
From:=A0Lee Trager <mailto:lee@trager.us>
Sent:=A0Wednesday, July 1, 2026 4:28 PM
To:=A0Andrew Lunn <mailto:andrew@lunn.ch>; Srinivasan, Vijay <mailto:vijay.=
srinivasan@intel.com>
Cc:=A0Das, Shubham <mailto:shubham.das@intel.com>; Alexander Duyck <mailto:=
alexander.duyck@gmail.com>; Maxime Chevallier <mailto:maxime.chevallier@boo=
tlin.com>; mailto:netdev@vger.kernel.org <mailto:netdev@vger.kernel.org>; m=
ailto:mkubecek@suse.cz <mailto:mkubecek@suse.cz>; D H, Siddaraju <mailto:si=
ddaraju.dh@intel.com>; Chintalapalle, Balaji <mailto:balaji.chintalapalle@i=
ntel.com>; Lindberg, Magnus <mailto:magnus.k.lindberg@ericsson.com>; mailto=
:niklas.damberg@ericsson.com <mailto:niklas.damberg@ericsson.com>; Wirandi,=
 Jonas <mailto:jonas.wirandi@ericsson.com>
Subject:=A0Re: Ethtool : PRBS feature=20

On 7/1/26 3:02 PM, Andrew Lunn wrote:

> On Wed, Jul 01, 2026 at 09:38:08PM +0000, Srinivasan, Vijay wrote:
>> Hi Andrew,
>> I think there is a disconnect here.
> Which proves my point. The specification is not sufficient if you have
> to keep correcting me.
>
> The kAPI should be understandable by somebody who has a general
> networking background. Please write a specification with that
> assumption in mind. Don't assume the reader is a test engineer who has
> used PRBS for half his life. Assume it is a brand new test engineer
> who is hearing PRBS for the first time. That is what most engineers on
> the netdev list are. Me included.

I think part of the disconnect is that PRBS testing is a signal
integrity test, not a network test. In this case the phy happens to be
Ethernet but it could just as easily be PCIE or USB. That is why it was
heavily suggested to me at netdev 0x19 that this should be done on the
generic phy layer, not netdev.

Lee

