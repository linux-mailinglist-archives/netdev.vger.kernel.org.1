Return-Path: <netdev+bounces-141507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ECB9BB2C8
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 12:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C341F210B1
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33CD1CCB46;
	Mon,  4 Nov 2024 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKBF2D9X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFE81B3930
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718168; cv=fail; b=aRpVZhY/4kyrH3kXj+8kIqduGc9LC21tp0abyKdTIaCS7klpKEEdavDM1V02Je/RZpaRq739l1x6ics6FfUsEqfxxin/LAdQAFs932nl1ytm6f2CRVNQo4HENJL5sxF+dsmG7TLf7+WwMbmGtPHeLvgObk+4xrh9XL9otvkzD7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718168; c=relaxed/simple;
	bh=wGbydMpL3WJK8XtT+sdseEdix48epjlbm6FqnyrDooc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RayvL5IOV09ErsBSZ0awPGa8+A1M/1aIIJSVaMhL8g8Wp5I9263h5MMrh1Fc8pZ53BaIU80KlstsSg8YMxib5dAZX6anSOvgth/M1/XsZLNlmsNxH2Db4Ld4e4Af40wefJR9xj5wI2BbzJN8B8EkbhUvrTiIMCckiv/mO+jAprc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKBF2D9X; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730718168; x=1762254168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wGbydMpL3WJK8XtT+sdseEdix48epjlbm6FqnyrDooc=;
  b=bKBF2D9XMRQnxruuODtALj4Lhc66M7HzRFtkdFGZx/JVTB+e1Om0dsLu
   3FERRig6L2vuafyDt5D6fD5SjUlErhFBtN7mng/wBMmnEAW8RJTcqyihO
   LhA6551fU4qR+fMb0BmFFU+Xo9vZGnGehtVi5AaSSRHuaMX1A1n13HBaJ
   P3qY5tgl/NxMgS4WvgLqtZ8KN4MwyePrYXap7yg34BRc0Z484A/mPcUBQ
   xUWQobdZf7CpUm3p2I4mpZhFAMo3q6Aowc7sUdlk++Wc04FkAjifIaKx1
   1T3HvQdvqHvR7406PGw7XBAIO9b6DWYp0v/7fd3dVG/mfStT/HhF5ljge
   Q==;
X-CSE-ConnectionGUID: cEja/04kTROdbb4l8MB02w==
X-CSE-MsgGUID: 0UQlS+DTRXywyvYIB4z2xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30585880"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30585880"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 03:02:44 -0800
X-CSE-ConnectionGUID: RxwA1Q73SLSP+kvceO13qA==
X-CSE-MsgGUID: ixoBZxyxQ9GwFp9QnMYf0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114407072"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 03:02:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 03:02:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 03:02:43 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 03:02:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6kT6VLYi79SoW6cZctS0KprH0AtB6GpxxMCsi/q8/MvpXtlmBwbRW0nb4W6E5yuMNsl1EzaZO2DbE5M/XEupXVbE+ROLMaoZ8L+4fhgkdRbzEWb1RVsQjJF/j1uAntcR+D/arpK0Mz5Nt3oBH7hsSQjlQFgNwtmWKqDiI/QjD1EaG69mAVcUFbkEz55vieffv2E81rPtjKEOC/MHJrd9d+q/w+wuGrg9hODxOsUrxZSWb71b8uG6yBMf0/YQ1ImlMr/8wdJT9LufmkuwXdYi3gIgEpEgr3XC9tdgZilturwz5zGZ8S5yfJjaybVslF6AiATM3a9wxNc53qiaIWkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nM6fXR72U1Hsa9RO/A89NW615W93hOv1ryMeVPZcnU=;
 b=RxnR2SBO6VtM4pb8yt02hdSFpJMkirFViCe/bQSszssAKZa61iAA8+LVFnyzMBO+5v33M51L0QuzVul2vcfj6rURzgFgAHSnUKAET0z8yNrdCYvyg8zrCCo2g3SyYCHspI1cBPokmjmPiXe/qQfFXEvDf0lZ8ejED2/N/zX18uTK6wJtVxBl4qalz7eSbb+SheCM1qDbks/lva5WEg5shpeGIe/37LN8nW2R+p8YtpUsXY3S0GcG5L+znM6XJ0Hc/2RFMgks2uPryShKumqyeo1cVNiiz7d/6S63fcFCTMm1tvFVsyOW0hdQrhph9+xHCw+kTr3J9d2iV/SG/1Lp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by CY8PR11MB7082.namprd11.prod.outlook.com (2603:10b6:930:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 11:02:32 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 11:02:32 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Polchlopek, Mateusz" <mateusz.polchlopek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v12 09/14] libeth: move
 idpf_rx_csum_decoded and idpf_rx_extracted
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v12 09/14] libeth: move
 idpf_rx_csum_decoded and idpf_rx_extracted
Thread-Index: AQHbJEUkoY0TAtzD2U2MhLa25Rcif7KnCWrg
Date: Mon, 4 Nov 2024 11:02:31 +0000
Message-ID: <SJ0PR11MB5865F2114C0F45F24A34CC888F512@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20241022114121.61284-1-mateusz.polchlopek@intel.com>
 <20241022114121.61284-10-mateusz.polchlopek@intel.com>
In-Reply-To: <20241022114121.61284-10-mateusz.polchlopek@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|CY8PR11MB7082:EE_
x-ms-office365-filtering-correlation-id: 35a30e7e-5693-4c64-3843-08dcfcc02e44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gtLMQOFkOhabBJHoQFh4aE7sQbrrEhgdlog16rp4ETJRifg8sSJ22BWqyIaE?=
 =?us-ascii?Q?5/5eblIOHX1p4UJJP97X4LXqvMfWCStFtZrPkHYAHGG9kETvwfVAgBqzFk7U?=
 =?us-ascii?Q?DqB/HeQiwXRYtIrgVSumB6bb/IDAuVNbAR2Z7lJ6KACpX0dLAZuaccC4hTw+?=
 =?us-ascii?Q?ZVQHeetMbtsKICrLSg+anpOEze/RtarNqV+1Tl2UDQ9FsLoo9rk+PhkyFIPE?=
 =?us-ascii?Q?FAIIsMhLkXPZ0PJpm8K4nY5qCKWPKRE16yz2l7zz6zLveizJWZ5zam5H6Q6R?=
 =?us-ascii?Q?Lq9soXO7i5slF+3ZP9p7x24RtsJX2Dmm8UpEUojOncsUIxoQ7bDiDNksVwsV?=
 =?us-ascii?Q?JfgwpxKfsVFhGGgGKibyZYR93FmUgf9NKrtXAqwyeJ/IS0np4+tDxFq11vTg?=
 =?us-ascii?Q?eEHRKjhJLGIqVzbkfgJJo/gwkN9ok5us8oviHj6L/8cZ51lBdlWHnDzhfWG5?=
 =?us-ascii?Q?9rZdAUZGLt2B5QqETHP5jP+1b2BFaugkVuTiEFBb9qZPt0qKdXeMlsi8wEDr?=
 =?us-ascii?Q?x7XsRTjohjQTBY5eUlNwOnDkmie7pLh7boBOx7+72h0WvSMPGkQ7nSpDkSsc?=
 =?us-ascii?Q?/xMdqwixzBI/NMC+H0+RdZw/CPeTnU/N4GJFUtLH9K0siJIMJdDANkqB7Qtc?=
 =?us-ascii?Q?6GI/3UkTjNblJ2DZNs4zt2ykoPE/w4mGqgkz6Z0J5M2z9jmFdJjDQRDYVrXT?=
 =?us-ascii?Q?d0yngx4G5eBhQVDKkA6mEu6csPsJ9OE6nYtOKZxJWn9gBlXulGIV37xCblec?=
 =?us-ascii?Q?cLggFJPaACgU5ggGyLswewD2vYAR8qaP9FL1SA9OVcDoNF0c6V8R6S0ik4wh?=
 =?us-ascii?Q?8Nm6LKeSyM4z5n5mfjU4LTBVP4iwk5D9jSfHwnfXHcTCEJEKz5pUq79kkX8L?=
 =?us-ascii?Q?5DZj75J3yC4bX6wF9imETyWMkdT91psgE1AYilVVWGc/bsJtCw0QcYZOqjqv?=
 =?us-ascii?Q?dVA0uaG2WXR8zxSs876VmzOTj2uIwBozZ2g6CWlbDLfPqWluCoRy8cr+xQZi?=
 =?us-ascii?Q?8tlwC/9JZzlQg/sAZgBPzLX787GV+ND36sRfxNFDTIzGi+AaJe+Oe6ux4eZg?=
 =?us-ascii?Q?ZE74gWAKUUx4YJU9y77A2r7dtQXb8sqW5ENCG9K0xTL3eNZEHyBoGsxSLud7?=
 =?us-ascii?Q?DarIynfhDDJGSpYJi97vFtgcpv0wqemT3qRi/6TxdZjsqpLfTUaOD2PuSZH1?=
 =?us-ascii?Q?sjpje7fmIoRFUTUgGzRYKOG4rXTKbUSx6Njxfhae8J91EYHFH0x85eQEGfux?=
 =?us-ascii?Q?h82OhPThK2Vi9FuEhLpBeF73/CfAsjl73/MQgbQNorNAk+ChbQe2ShICjk+N?=
 =?us-ascii?Q?g+WjuZqazq/a5Ix+oRA6jUhD8wCZFIESWyAPf14xn/QtJ5NcEulkBZgCU8z2?=
 =?us-ascii?Q?WHejF1E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R8FIHKRxhklNyZdPJkQ/JOaH5gvkBc4KnH7xK5z/T/6eJVjFA3mqbvO4v+uo?=
 =?us-ascii?Q?k+d7ruFjqWJpREhdBLGV7Uq4u9qFubxxmwCtDLN7fjOqXGud2I22dIsgg+tn?=
 =?us-ascii?Q?ipns4BMaj1D/mEj2wRje89vdTrMR0wE74bI+Z1Td8DKFUEYoI0Bzkr9D+Zb2?=
 =?us-ascii?Q?Ko21UvFgDJSsjuV97d4wh8a907oysjYwpHBw7U8+5B+QQuRP1a3MnWXneOE9?=
 =?us-ascii?Q?GypS+aInGO93gneN+u6zPKHinR4uUIIu4dvGE2eUGsdk2r+i6qw5FOiCtlVP?=
 =?us-ascii?Q?zsp9O+esWwLk5A8LOXdUQ7Nf6opoQdgBOp9wCqhYRzJDxy171E0LKnhJXefj?=
 =?us-ascii?Q?9R0qaebrsHHH0aMOjTIpxsTt4YvM7U/TsKLIXt/WagwYP1MXWaTn5zMhmuCk?=
 =?us-ascii?Q?0HCBQI1krBiFZj6Ux8E51BtuGXiX5hotYDThjsG2KU8nzBI0vTqlh1Ez/Qcr?=
 =?us-ascii?Q?Ru0QIeIBOABpeWskWSCLvRgF7JPXqcN9gIXI64O/EDycEt9+J9sEEEtrJcnL?=
 =?us-ascii?Q?BWVbNF9eZOqo7oL+KLxsS7znVnl7iqD3Z4ke3Zc5BGiT0nvPlbl84c9uIOdR?=
 =?us-ascii?Q?byVaKADIP8ovB5v9Y9swc8t1qRHeVYg82elXXjTn+CMD1HksYsW1NrDueeIr?=
 =?us-ascii?Q?I+c4IQ9Bd10d3n5anjHhChR3xfDhdSky8hNeiHdT3cl5k1BNCDjQuQsG6Qil?=
 =?us-ascii?Q?9D+Yv0fZjQU1EgcwK274RfGT4eK4plR73NdOt8FkiRIgIf6ZYjRVuUPz+Ehs?=
 =?us-ascii?Q?qZIQyxAxr4heGDsBelSdoOO/WUBOJ1mhVRix7eU2w3nKcJLoffK6WrNq20q9?=
 =?us-ascii?Q?TFuoxJxLORb6qLvpPMbETQ23JjF7Nai9iUavycsvb6vil8PjkgLjAy0VS05U?=
 =?us-ascii?Q?bvaX4zhhExfA8TZ6knEFh408uklIW31HxdZCsyoBXa0eHB+ohAMyTky5LFs9?=
 =?us-ascii?Q?gOmxqhowspJvAqF2IbPdrNfKRPO4z3xmsQ/+OUmYJ/S5W8GV58JLYoSojJDp?=
 =?us-ascii?Q?lrjKXdOcKbHCseNYc7vLO+l3SB/lc6jA/ZGd/gSG8qALS0LP06NcelQfDAet?=
 =?us-ascii?Q?5OmM0Ft/4ntUjxHr37jeu/dEKtvtdYwr2zRdMpCs2kavShxYvMajMFzVGVWx?=
 =?us-ascii?Q?4HhHV/HZSoTmbIYzyq/ENnMaBS78vVfxGdOguuuEp09LNYLh2k9QzY17oka8?=
 =?us-ascii?Q?eAODcDeEXbCb9FR6VNkVpZ6EPsNZyKOa8wHmoFRhV1cBdea1fyNHZcX7jwgA?=
 =?us-ascii?Q?EoRMWv09lEqyJHCJ4leykrQgM92x5C7uZQBpbv0GDC2cuTDnpEzRqK8yfnCD?=
 =?us-ascii?Q?ZWGH+tBWmAU1zN4kVM/bb8QYT2ZiY3bIbFPA62DRSqtF9AJ2AQbLTYXebT6a?=
 =?us-ascii?Q?k5jrwVdcck/9jI04F0UvohlhH8p3lWhVFsfXCgaSK+hoipawnkXh1gSElYbc?=
 =?us-ascii?Q?bw3BcZW2cBLA4zH6HWlrLcLldd8DcaId84V+bX/z3qUNuBruX83lnsTLPge0?=
 =?us-ascii?Q?Chdm6QFzB9b66bosstM0MfcPzFD1NMR1t95/nTlU5QELdKMP2F0qT/oYJehD?=
 =?us-ascii?Q?7/XnJi695cv8QP1dcxTL7LUDJX9zgEAIWpk+1ldnQJ+RbXoIJisuJrWUeizj?=
 =?us-ascii?Q?2A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a30e7e-5693-4c64-3843-08dcfcc02e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 11:02:31.9392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NiB5FSrDV97GK3N6SXvU8gpVgz2G+xPeqY2ISxElsDLfXBqbTGoUxikarG7o5dojbhABkqYEpc4Wd6aJHzr24bseRqvfH9zJpyGxW/LXooM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7082
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Polchlopek
> Sent: Tuesday, October 22, 2024 1:41 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Polchlopek, Mateusz
> <mateusz.polchlopek@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v12 09/14] libeth: move
> idpf_rx_csum_decoded and idpf_rx_extracted
>=20
> Structs idpf_rx_csum_decoded and idpf_rx_extracted are used both in idpf =
and
> iavf Intel drivers. Change the prefix from idpf_* to libeth_* and move me=
ntioned
> structs to libeth's rx.h header file.
>=20
> Adjust usage in idpf driver.
>=20
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---
>  .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 51 ++++++++++---------
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 16 +++---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 19 -------
>  include/net/libeth/rx.h                       | 47 +++++++++++++++++
>  4 files changed, 82 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> index dfd7cf1d9aa0..eae1b6f474e6 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
> @@ -595,7 +595,7 @@ static bool idpf_rx_singleq_is_non_eop(const union

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


