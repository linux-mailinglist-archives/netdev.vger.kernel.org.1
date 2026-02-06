Return-Path: <netdev+bounces-257522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBgHKjPFhWnAGAQAu9opvQ
	(envelope-from <netdev+bounces-257522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 11:40:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37901FCBBB
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 11:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A5C73006780
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB17366DA3;
	Fri,  6 Feb 2026 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhfRdzT3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE9E30BB81
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374448; cv=fail; b=ocE6SZUSsBnRDL5DtdJpTt+7PDT7mpXmtj/vuP7VkcuAuWaL9DjEYmlL/eVU4JXxgNb+SWmSh2MaDxmIH+PNE11LSu7zFYq93cBiAD+yltSl4JZ9jyO2FN6ihCD3avSgWzgg+h+V/JsyIERXuCHX6b4yKwaXFLZGcxi9BCdHn1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374448; c=relaxed/simple;
	bh=bMzTchc6i/3HEbQbegRD3VCldfQO7LMrhy90bM8be2k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OqRk3bWH/La/pVxEkuPF13ACB91R2p04iaref3NFlIajZcbwxBpWfPOLNAn4AuF6aEOq+Is26KDLn1N2vbU//mnQiJR2rr3fPLePCeFlQ6pdSUT+L+EX30WV7Jtd5w6aXSdP3iKV8V02hfInaiuYQrCddWfCjJjEcuBbjcqOweo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhfRdzT3; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770374447; x=1801910447;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bMzTchc6i/3HEbQbegRD3VCldfQO7LMrhy90bM8be2k=;
  b=mhfRdzT3E4hB8TiCPTizw+yudXFUYK0XgrHEYwCcBkLQrHsWaBef9DSu
   dJzH+i39u0Ad8BGEA/bTPi4YNsz7LvHeGKxvu6orrSG10KsYk2ef8Iijl
   TFS04edsrLrZtalrPsi/4iKrGaRS2igm76HZYZWtGdMMyDb6SyOxEZzrE
   PN3bAnjDS6INrk1HuRqP5+dIwHgVzSe0n3do3Mo5OQ9bO240Qfzvhp2Nv
   RxDMCfvIzUUvYehpxyxDOPHu0emDKj7PeSPsQvCQanmB5janWiyAe9wqX
   FcM8L8LuCgw8rAuoLfAdiPC12Ct25dE3WtM2OdU3UrQh6yVpM6656YvCv
   A==;
X-CSE-ConnectionGUID: olBK5igyR6mm5Nfr+hVWrA==
X-CSE-MsgGUID: vpIgeeQVTgWiVN7XZ8i71Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82318242"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="82318242"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 02:40:47 -0800
X-CSE-ConnectionGUID: RYPiHoWvTkOil0QudcPY+g==
X-CSE-MsgGUID: OrJX664VRs60X93g3hccMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="241315093"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 02:40:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 02:40:46 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 02:40:46 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 02:40:46 -0800
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by MN6PR11MB8170.namprd11.prod.outlook.com (2603:10b6:208:47c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 10:40:39 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 10:40:39 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Marcin Szycik
	<marcin.szycik@linux.intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: refactor: use
 DECLARE_BITMAP for ring state field
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: refactor: use
 DECLARE_BITMAP for ring state field
Thread-Index: AQHci3xAjsW08lKozE2dA8270x3l/rV1kBfQ
Date: Fri, 6 Feb 2026 10:40:39 +0000
Message-ID: <IA1PR11MB6241CE83E79C25C8E17DDE388B66A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260122085039.1117442-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20260122085039.1117442-1-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|MN6PR11MB8170:EE_
x-ms-office365-filtering-correlation-id: 5a262a40-19d2-4dd8-d091-08de656c2b74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?BHI26XbVrMWJKMYPUp6rdPA0ILjJBCJHZHCGxOs/lOnGY5FoX5d/dOZDv7UQ?=
 =?us-ascii?Q?xno2qTXVem5RhLyMM1oZwm1oT70LIvC0t6RBpf96ofZjfBo4NtdxMR3rWNsQ?=
 =?us-ascii?Q?4jBFxw7IeEAxuEiMREN0itFDH1WkUNus3qYZav5g5b64bCpD8ZPlqju4dVy2?=
 =?us-ascii?Q?VFzAymAJ5o/LpRE767t1VcmCX1gfcFKeOSi/TBrBoWXhqGbvmJST03MuXYZv?=
 =?us-ascii?Q?ImdQQq2IuysVBm6dJwLnBs75X5i4gTI8Sv6YejFz8V5/D2ABh8HdKZwR5MvZ?=
 =?us-ascii?Q?Y/LwieYnH2XzcWyMly22Qajj+wXCy8xXr/M2xtfPyWCrnRiSgOJuG1bPXVHj?=
 =?us-ascii?Q?3ssN3AqZq8JFZWyzCkzuaVWh16tUPmS7KVW0GIZ5rjr9RGchDguK8OA6EVF6?=
 =?us-ascii?Q?nXC982u8BOC/Z29IoQY+MOix7IPF0cRFt2/Z37Llq7xqhGOjSHiLf4N+qcyK?=
 =?us-ascii?Q?TQymhRjj/PECBbcEYb1WcA6Qaaycjkbdo3BMvx/EiAOQglL2esAw4Tx6nhog?=
 =?us-ascii?Q?o14v0XrORcVjCLuTV55j5PB7gQliEzXor5Av57EMDtAo/gkB/7QJqXk9HkTL?=
 =?us-ascii?Q?ziWv2PpKToLGp8NDoH2dFQwuLuAecBUAxFSz2wBy06hFWIBqnLrAuNM7SCmi?=
 =?us-ascii?Q?W2pTiEZ+4akCE9deH9fIXEElPsDCRyTenG4/8lxpnR+GmjeHhWnbZIXkC/Ph?=
 =?us-ascii?Q?t7kUbOC+njL6Vz1X/lokRs9tNnLasqtEb91E/N0CP2dUCSd18wKtj5HZQDDR?=
 =?us-ascii?Q?WUYdC0J3StbdgP9/704i28vSxrA6skt/CLl0o3F04hdYG4GiHnBdfkC8mgmV?=
 =?us-ascii?Q?KM2YNd3J7GMPLOZOwZxt/eJOB718EBeWFSI1f01XcX9ZQel5hWiMA0rAohnR?=
 =?us-ascii?Q?R8VYe7cy90yIvt/pu3YTpdS8hCAndRY3Zvrtm8F32W+m4YFDmIXWawL3yK9T?=
 =?us-ascii?Q?9W1ciOCD0p4sAv1pk/XT/VB+mMl3ACLxxVc3qkAsnJA71lvcF6dave+nPILM?=
 =?us-ascii?Q?FGWYhTQ1ONjzJoJrBQRsYa9wEn2lDkmu00xfdSKKDWUHPySFcJgTXd9QDPrj?=
 =?us-ascii?Q?O4/OIPCrW/m5F3DmoP8BOgQqFwiOuDN715r72holcvddWROsp3T1EwBV8hNm?=
 =?us-ascii?Q?Fs3dBNbQOXlcx9DHKb2QmgPHvf4S7/1+W45Wuq4l/zjbxLvB4cW95L9kExqy?=
 =?us-ascii?Q?Om14ZnQB/DvJksSMk+ybdQHV7QbWRnMRNBAPRL057Z8dFJ9g5DkwnA/iFpNH?=
 =?us-ascii?Q?O1PGrIctnVXqKo3wmS/PqQ9elZWsOPsFlSQy99/KBOZPkg1TROhNQ7coZs+Z?=
 =?us-ascii?Q?BA19/f+H8hgO4HDkLKMh5I7R7Go2Ucu++ax7il5WtnkK63uOwLhv+qFbXFl5?=
 =?us-ascii?Q?jKRhIZ3Tl3d9GLjJz6IX35b1FVJ4Sxm7sKHl66J5qWYUXtZt1DKi51/hdeev?=
 =?us-ascii?Q?zczN9C+MTF8I5PGrX/ADdRvNLQMX5vPoQTMfz4DTk9n4FK3Cedxw4LOpY+8v?=
 =?us-ascii?Q?MXVBsu0N5blMMnmRO7evgxlPDLxRr70S4W2y2R4cCeQUrPYbUyL7J9wKYFs0?=
 =?us-ascii?Q?PqTtjwGGOvgEzJFgR9y4tbI1o82DClntuZTNulJJcvvCLGjUdyKyCWl4ct0v?=
 =?us-ascii?Q?wz0qgmfsQw20ZG/2bfA19+M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+SiXnVvxYTL5AftRCQtLPaFlc2ThKGDnvdqNxrT4vREygmzSc8fDWVShbLIi?=
 =?us-ascii?Q?tsAh38TYyz0dmKQjMl7NzF58KHv98YvTFBTZnSSVGvsDk6OPGTF8twKh9HpI?=
 =?us-ascii?Q?PQ3KiXvHP4HMxr+8YHjN1GBxWqYv0Dv1Vqhf9cGxgoMtJvdX2xD4oSZZxStm?=
 =?us-ascii?Q?oA3rdkS8bsjJnJurU9iDTvPx4fjJwaZNqwNdhfbwzfOUQ9oyczDxt4XJbxtm?=
 =?us-ascii?Q?Q6SL+tYgRBE1W8s1lyPfLFnw4UDlt2V0eJi1kWw7W7tdhKOXdBo18jDTtI8g?=
 =?us-ascii?Q?+6fb9BKXKGyExJBWFvrh/llGHo2LLzq+tTMaug/LHtZqxeLiBgaH9OjJuwbQ?=
 =?us-ascii?Q?9vr6NNFCtOrF76lV3c5R4VmNjWJnIxbMpAkKA8c/4CSe/DKYU1HhhVcDkQrw?=
 =?us-ascii?Q?5HaAUTczXK0YUIx19Xkz2N76D8czxeiircfEQNDgX/wb8oKW3ikkZ/UsRidy?=
 =?us-ascii?Q?CqnHaoeH1dz2Jey48FjOnLmcvIZlzLMYwGhUpNasIbxL9mCDXhzxfbdxMF7k?=
 =?us-ascii?Q?EIYfOsv3Dg3mzubgoupOYwRa2PjpYKCxNKrwWxvq6ssiupZn6EAwrPeox/jE?=
 =?us-ascii?Q?F07fDFay8LWwlMaljdsoEG/1J742B+NzAx9541NIu1prUTIZx0HA94WIc8CJ?=
 =?us-ascii?Q?NAqiV1DO89l8ZGt770WTDTXnHd6kAQvt8Qw/iB08LG2y43K0WCju/4ROpbEM?=
 =?us-ascii?Q?0RL5Wcao+K8MqnMGtODAEj63MJl0QHrDPLsitq4XRFmEKEmHaFDx89/vlmEA?=
 =?us-ascii?Q?WuHnHdywfSoo+XXvfnnWtL9nRPMZPq7Vr9/a53hXOSjER/BkxoZl2Jp/pUYo?=
 =?us-ascii?Q?RM/ydbk9bDVeGRrCat8vyIqBbXL7G60oLML1QE5Lie+xqy6SCsj8g8Y4B2ml?=
 =?us-ascii?Q?RexGbZHkdi/luYiTHLAaytWbH3cphDIkkH7Dq6WF7jKGb3PtGgrCdzOYxyak?=
 =?us-ascii?Q?PLGQVT9P6mk+sM5U8pJWob9iZhHqev2/YZFzniGHEojc2PoXORVbrG8/gI02?=
 =?us-ascii?Q?wvDgivdzyQUTe1sTk1LKxGIiW/uZ2KxlQmG94FxAHTkVvfsMZ2C+l97n3rpA?=
 =?us-ascii?Q?Bc1MDgjyZGThEs38/8uvtRIqqwg4b2VE+Quav5T70jTxWkKp4Mr8Uq8Au+E2?=
 =?us-ascii?Q?XTmdL7+PlFL6GcaQ8qOg5YT5eCUlLtHOqSrAXnBEj69Zmw/TQo5nnI/GqHkO?=
 =?us-ascii?Q?noPeHwwGM48dNNh6KyDJyN/s0oV/BowXKxq2Lwd6jEJ4tu7Ki/Wxazg5EavL?=
 =?us-ascii?Q?BJtV4FtMI28gSyGVxQaJyxMOWJZaf7Baz9LIFNqcntMaIUu2rV3Vn3etdCWV?=
 =?us-ascii?Q?hKTEkZjaqVObFxSXWKx6j4m/hrRFr0EdfX6Igt9WzezHbPfi98r4cFG1ium/?=
 =?us-ascii?Q?W06DecYWOCzmRGIzoWujGaTAx29sfXb/8lO5xseVYX2/xWCeqi97FOghu4bR?=
 =?us-ascii?Q?HYhGle6MEBUU7AJcZV0c6IO9rlJnhdViE+FmcikL5IOZcqYg/4+MBJDAPgfd?=
 =?us-ascii?Q?+yh9rHcN27tPAR/q/+wvC1mr7Zw3pO8TU3vcU+9V/PJ4KanKzUS8BzG9uHO/?=
 =?us-ascii?Q?8wxigsmAs3ekXs7581trwHfPEhVbQfQhb9X9byTsgGNamUWEWqDB4YqZ71X9?=
 =?us-ascii?Q?46SUWKp1obSsJHJzmZV+HjHGHzH03/QJkCczh6GPRN7AQN14OXRbMTZ+irOY?=
 =?us-ascii?Q?qGik78CCQ5l9iKMtTE05z4w6vmQTmR36ZpLL0Pr9xUvw5MsJ?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ikt0DQYrooyVwM/xh1y2HMIIcOkbja1LgbBq+OreRppTPrtcHp/DV8jxjxcSxkTLAGyGp+H+37CJPJON91BHkUPR3qspANrd/zLin7nw/xzb/yxJY8qNmuAwNQtr6JVzGCAPqzAVbjqrf6+t/XESZAabdx0E3zje1AUc3pkPJ/idop41Fh9IELTLo/Ql3Z8k8/sJtc++Sy0SGQ8dTFEuzht/paoRjXReHL7ZRVbeQqhJcQF8KRissJcTtAxj3o8s4rNgxDwSSwLnbmxd/M5u8vQjijy8K8557S4dITZclhy3GeHLt4D9aQUsmqpnCuCI5GOc+ryys4GOvDYPGOzLUA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHxB8zuIeYwbgRRqojVnf22dYJWtlulgEskdZdYSKYs=;
 b=kCP5Y1K2iywiqSr5ykeeITvVmKV8Qs17XsqiWrbX6BygOlNjQ6gJKNymvQtCj7OqUMFfTbj4rhIbv5gTvXRYcmWBPRF5cz+y3JyNzoLOAVg6U1TkLs9J9wDrIHBp9Rm9WDWAJs1LjDl0EICvFLCfiRDUv6+lPweuJ/3qj2bwBoO1r+Y3LDiI1cejV4+zZgGx1BkxqhPMYIiRvQWFE4ng/WhDvBf7ZpCIXDHLrNmjaRjMeKwM4Iunt8km+GvI4juB5XwhVLjs9hBRkHNqk1hqrlQARP5/GppvGaAqcw+HnUJNShJtwjUxOMAEPgfNVzS0xV0FMawlSNq9zPvDpsxeXg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: IA1PR11MB6241.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 5a262a40-19d2-4dd8-d091-08de656c2b74
x-ms-exchange-crosstenant-originalarrivaltime: 06 Feb 2026 10:40:39.3105 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: RiMi1OBeSYdYRc3qX35PNzpPCwh27sgb/X+laeWWsUbMDx/XHgCT+X4hQx7+CP8F6FBSdZFdegmnbAGhXlMncA==
x-ms-exchange-transport-crosstenantheadersstamped: MN6PR11MB8170
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257522-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 37901FCBBB
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: 22 January 2026 14:21
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Marcin Szycik <marcin.szycik@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: refactor: use DECLA=
RE_BITMAP for ring state field
>
> Convert the ring state field from 'unsigned long' to a proper bitmap usin=
g DECLARE_BITMAP macro, aligning with the implementation pattern already us=
ed in the i40e driver.
>
> This change:
> - Adds __IXGBE_RING_STATE_NBITS as the bitmap size sentinel to enum
>  ixgbe_ring_state_t (consistent with i40e's __I40E_RING_STATE_NBITS)
> - Changes 'unsigned long state' to 'DECLARE_BITMAP(state,
> __IXGBE_RING_STATE_NBITS)' in struct ixgbe_ring
> - Removes the address-of operator (&) when passing ring->state to bit
>  manipulation functions, as bitmap arrays naturally decay to pointers
>
> The change maintains functional equivalence while using the more appropri=
ate kernel bitmap API, consistent with other Intel Ethernet drivers.
>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 27 ++++-----
> drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |  4 +-  drivers/net/ethern=
et/intel/ixgbe/ixgbe_main.c | 56 +++++++++----------  drivers/net/ethernet/=
intel/ixgbe/ixgbe_xsk.c  |  2 +-
> 4 files changed, 45 insertions(+), 44 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

