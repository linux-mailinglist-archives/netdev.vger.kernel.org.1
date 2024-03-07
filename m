Return-Path: <netdev+bounces-78365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28862874CC5
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 11:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA621C216F0
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F1A126F3C;
	Thu,  7 Mar 2024 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="nbj/9lPd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F712883C
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808896; cv=fail; b=XGGpPzJiKfDoEsAF5mRxnyWI4/BXwAckdWEL9ZX1D8+iv63mvjbY2F4oWKjlGmFFRYw2/PI3NkJPRsjtAtrPve01ByoRD4rCBjZnss2pDDzIPwO9+QzbJMZbwQWD+817KJc5JFJ2+1qyEjWHcmGk6dvjkTTpfSBs75NI022hZMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808896; c=relaxed/simple;
	bh=RahdJfvoNWxE30SIAM+6WRgo6WsNzH4fq2suXWrdjaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gXKhnZWBcJNbP3nEEt3t1ZP6Uxj5hcZmWTcX2frcxk0w/DX3SgIMcC5+a6GbA9pMduXod2iIis8kgNhC5GL5LeJAKPf38x1RVLEv9vmqKPd9ELORayLfMJiG9raT5QHYcfdJ7l+JbJRK2OiX4w/0xxAJih21zOgASTeglKPsQ/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=nbj/9lPd; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4275jWvj008216;
	Thu, 7 Mar 2024 02:54:45 -0800
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wq7q8run8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 02:54:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nh/HOP2848l/YNu5QUTD5UGDwsSDSCoFYQCwZQILoZYN9/YYzXr28GPxzyCV7vsw/86SrevguZ2ucNmcXlxxaJe4qBGGBtchaYKg6eja1OFWB1J5/THXGpXHJi2gHVhk4OHVLgOPpMTyygrxGLJ/LLBYZwG0oq+eAi79Z/f3LQKkXJkHpfC0kumqrKUT/ziGeXCZOsOtViA3BxFdfwuuyj5N8q2scnUyHOX5fTLlBZSzu4tuUH+2W8mF/NHtYOlPbSztF/aCS+Sjtg3xjHazs0hfzXURRh0XPPOc9Tc0jUmSN3idnPymSVl3ICVkCaLrY5VoqNX8EzeZnQgDBGhQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNGeR9med27BtXECQ+QdOBI8ihlgky5WRW9yVmXZr4U=;
 b=BcK68aaebnrwB32SyE3QEQR8CAzK9YtmLMCrAyJiBMUiObRPIQG7nmvJ1ulQg5k+Q7lNLx+Qoh/jnqVJQ+TK/dOFpogsvpPWJYrsfQ3W+x8L7rw93yTr73X5qFbTuNI6HcoDTbA2r2HJ0iNKwf49Qz6D6LHm8bBeUbprD18T4J2ezjcUFH5hKyRZYeuYw2Cm5vqHCIcqaz8hwd2ysrBG83g9d7rp0nlKvRNfGHA9nBxX7GSWapgQLej8azu9+r/8Ff6xyNzT0i5tdi70MeBWfJMVF4E7ZmuPw4oDmLNd+VIfaNU39hikSLxf7JyciZ0PCcQRce1T8RkE3ByNhyth7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNGeR9med27BtXECQ+QdOBI8ihlgky5WRW9yVmXZr4U=;
 b=nbj/9lPdVPmkDGAo1TL8ybBrb68vml8vOwFEMO7GHj3Ypk+iP8eJXs72LSZQsgRJ5+pwLb3qBsJ1chm0yOxusMMvUTZqoLKzD+GePwzGgksdX1bh0EstSkAOzqrtjc3Qr/5H9vLAJKTaA2HAuE/YDzTM7jlPVeCMT8PoJ4akjtM=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by SN4PR18MB4856.namprd18.prod.outlook.com (2603:10b6:806:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 10:54:41 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6%6]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 10:54:41 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "jiawenwu@trustnetic.com" <jiawenwu@trustnetic.com>
Subject: RE: [EXTERNAL] [PATCH net-next 3/5] net: libwx: Add msg task api
Thread-Topic: [EXTERNAL] [PATCH net-next 3/5] net: libwx: Add msg task api
Thread-Index: AQHacHbPmTj1dnjei0ykcE/isb0dX7EsGhvg
Date: Thu, 7 Mar 2024 10:54:41 +0000
Message-ID: 
 <BY3PR18MB473725E6A31B49ABEA184810C6202@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240307095755.7130-1-mengyuanlou@net-swift.com>
 <74A88D8060E77248+20240307095755.7130-4-mengyuanlou@net-swift.com>
In-Reply-To: 
 <74A88D8060E77248+20240307095755.7130-4-mengyuanlou@net-swift.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|SN4PR18MB4856:EE_
x-ms-office365-filtering-correlation-id: f0af7643-e34d-4c73-06b5-08dc3e94fdb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 s5YZ30hb534Q7Ucs/NhAc/MMv+S17/uVd6muRdBjBeaJWTeMCoV/JMFJEXFHqkfeVo1WP7jm5++yhqJbII34hDz4mXlATnj3sjohjvkmK8YNVtqgMSSsQsTz4X7eIlGbF2A6z8ftyTVqD4+hiumrkIipPn0hPyGY7Jkti4cdnCOWcMG7QVP0HY9kFdeZZjpJOuVU32Wkz3PaONXpVA3qEPqw6R2eHhwDPhkqUO12bwqYBCIYxigeY+oSc+E4/asGi0QYYhR8GFpvMGjh9ezX4bm12oG7F+hh5VJinbE0CP+GUgBVn+BETrTqPGiuepCLgDnVwk5bunbjHxvrplxqj28ZUb/v17I9JG5WvJQnCIVZ+ahoF9/qeYL5E4FAeXrDpt+VQTGRkIBTzd9oE0RsvXxONEuoNwynJBLy390IeuEMZC6xVXiiIXA+qxbe/K8GlqhK+uG1MOUXzVMEfn0rjkwRNvU7Por90w68ofJ0N7PhTSuSBMW6u6stw4HZeN1KXw66lc6piuvqjmdC1RhgMNLsBYwTChU6zVv8VzWB1ZDdJsejWJjecn4bf76eUu5zBugvNF9Ac6cZHfhiTs8H9oAmn87lNBM1rePJjx93YB1p5fAiP63gNejtu0mas6OZSoFzhMkiBf81bxwnLtzTtHf5fusiYSiDACrMtn2dwSi74JL2iL78qjAd4nav96TzmUgXfFvp5uAvRx+1IC4osw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?x5d/rJQ18RuN/a8MejI8uo+i0ies3scta4aJJ9d1RvZrR5IfAiYC+s4Iv8ur?=
 =?us-ascii?Q?jB7FHZE5gOHQA45bZMsJJpJahse/Gg6/INdCqd5ZJ1K+6KhrdrpUyVA/w5xQ?=
 =?us-ascii?Q?EY7oY/D0I2a43/GlTQ36jYvy9dwxlg6aP5Kmw37tB57Woo3pMN9Yfcp61zGt?=
 =?us-ascii?Q?KRW//69HGztNT9FNH4ZDz1b0iX9srgfKB9mERVrtKa8py92fx26VbDHFcPvH?=
 =?us-ascii?Q?9wQGUqXtEh/M548WaX+NACsi6jiZMxPeHQaVdCKedEwVlVOns7lI3MUHje4v?=
 =?us-ascii?Q?0th1UlcFzFbNn/qYfW0jDSeW2Ds32yzEPRLDP2gpHna++fTbU9DFraWgBi4R?=
 =?us-ascii?Q?grueTND1bldpWHtyF/aCHzPHxfG68Mzo6flA1YkXvgoSIDLcVtcZGHgYk1Q1?=
 =?us-ascii?Q?JUfzdWRBUwcVWf+UIrVkkLNIAD+30O5e6cW930xaMPRBPxmXArrHmXy1pSjx?=
 =?us-ascii?Q?W9rKzGfYsteuZ+Cw72YwahyEEhh4r9iQW8+J9GXwLggtNwNJtGTVVpCgOyjm?=
 =?us-ascii?Q?LOA2lqeBHuETUcT8zabJ9c7BjH1gTPGhHLWQs0me+mwWeUujAhLYBI0SfcmO?=
 =?us-ascii?Q?LqSQA3WZrMavfzLUkiXPTpoupwoNDRLoZGkRDSZ4NMZUSB0BVLgWeDJ82QL4?=
 =?us-ascii?Q?SGOVwbRTO8u4r3OoAjj9e15M7YDKZKWPHONfGSxWlkrrQefzqJWJ07CH/o54?=
 =?us-ascii?Q?HR+4T6zzB8Jca1tkaeGC87mdIUn1mG5y5ynTxj4ihEGYx3VegxV2i1FeNmi/?=
 =?us-ascii?Q?+mDeQ3ZAJKJcEfV0gzdPIKc0O3YLMUFtK5u9UfZlDKTLZhtIn9UrXcE86ykE?=
 =?us-ascii?Q?v+kmJw4b9RYAqqm0o6BF9rMxYbBXdFZIQ+WTqGRQBYkjMLZtrLok2Rrs1lKi?=
 =?us-ascii?Q?dWnTHF0Uf0zmI3+q9Yr8AdVY3VbHUFqFr/i/LOMD7xGLVecjzMPc81lbDXze?=
 =?us-ascii?Q?EY7nPBvQHRUaFVjVDoiWaUERnbje6mctz9Sy5Od7krkICsekwkIISXP9a0Ag?=
 =?us-ascii?Q?24IkrFiBHjimJVVLSsMMyOoCrEYfzE2at50Pa5pWLt7wJekH7UNnunfbrpAk?=
 =?us-ascii?Q?+nZz6VLbWPaeSWgYgLjGOLewKwpRAioeTvV76o8EFl/DweVH113v3w1WyNk7?=
 =?us-ascii?Q?MkbfJzrBbCBi7nGC+NsxgqLlAbhY5EEcqQqKMCS3BozMTIb5wSw0t/2YEpNF?=
 =?us-ascii?Q?qwA/iEmqcw248A7aqe7kQopBkPhlMJNMo46HOulcZfdtAyR4IfHz6oQVC8sV?=
 =?us-ascii?Q?UDgEWerB6GaX/Na/gz3NjhZnGLGVteIH9xsolvPav13GiMkuQaxzBdVWjjr+?=
 =?us-ascii?Q?M1/HvvjOmn56BzKU2eLSr3mLe+2ixsmWAKvOCBkaXP2VestzrFyRWIYLiA2p?=
 =?us-ascii?Q?IClGB4ppp91XaxyJ1OcVPfUpzCqWRb3QPz31A5DmWK3bSF0KK5z+SWZoPDxE?=
 =?us-ascii?Q?5MPARYZwwyPOT4uhOlHUiayXK42XmYbk9i85S3mwT9uWjqDz84zZV2V5huzp?=
 =?us-ascii?Q?9Hvyd6gkJzXoduAkjhz24AkbMQxmj1wxS5fFWER16ssHCuKFP8+0SuMkVRYo?=
 =?us-ascii?Q?Y0F2HtdZTg5JbKle+OnHQHMx75mB+J8be0WazVqN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0af7643-e34d-4c73-06b5-08dc3e94fdb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 10:54:41.1972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1jmI2GPvz7yHDfg7KyBRRYS+cmq12w6NRU8F59PdHavEJL97AgLPhGyGPJdU+F/DMCLVtzyOu+zZOzC1A4Qxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR18MB4856
X-Proofpoint-ORIG-GUID: JRfL5V6zHI_NfjAXqTaZmR8igAZPt5nR
X-Proofpoint-GUID: JRfL5V6zHI_NfjAXqTaZmR8igAZPt5nR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_07,2024-03-06_01,2023-05-22_02



> -----Original Message-----
> From: Mengyuan Lou <mengyuanlou@net-swift.com>
> Sent: Thursday, March 7, 2024 3:25 PM
> To: netdev@vger.kernel.org
> Cc: jiawenwu@trustnetic.com; Mengyuan Lou <mengyuanlou@net-
> swift.com>
> Subject: [PATCH net-next 3/5] net: libwx: Add msg task api
>=20
> Implement ndo_set_vf_spoofchk and ndo_set_vf_link_state
> interfaces.
> Implement wx_msg_task which is used to process mailbox
> messages sent by vf.
> Reallocate queue and int resources when sriov is enabled.
>=20
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 312 +++++-
>  drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   6 +
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 146 ++-
>  drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |  50 +
>  drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 885
> +++++++++++++++++-
>  drivers/net/ethernet/wangxun/libwx/wx_sriov.h |   7 +
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  70 +-
>  7 files changed, 1452 insertions(+), 24 deletions(-)
>=20
.................
> +static int wx_rcv_msg_from_vf(struct wx *wx, u16 vf)
> +{
> +	u16 mbx_size =3D WX_VXMAILBOX_SIZE;
> +	u32 msgbuf[WX_VXMAILBOX_SIZE];
> +	int retval;
> +
> +	retval =3D wx_read_mbx_pf(wx, msgbuf, mbx_size, vf);
> +	if (retval) {
> +		wx_err(wx, "Error receiving message from VF\n");
> +		return retval;
> +	}
> +
> +	/* this is a message we already processed, do nothing */
> +	if (msgbuf[0] & (WX_VT_MSGTYPE_ACK | WX_VT_MSGTYPE_NACK))
> +		return retval;
> +
> +	if (msgbuf[0] =3D=3D WX_VF_RESET)
> +		return wx_vf_reset_msg(wx, vf);
> +
> +	/* until the vf completes a virtual function reset it should not be
> +	 * allowed to start any configuration.
> +	 */
> +	if (!wx->vfinfo[vf].clear_to_send) {
> +		msgbuf[0] |=3D WX_VT_MSGTYPE_NACK;
> +		wx_write_mbx_pf(wx, msgbuf, 1, vf);
> +		return retval;
> +	}
> +
> +	switch ((msgbuf[0] & U16_MAX)) {
> +	case WX_VF_SET_MAC_ADDR:
> +		retval =3D wx_set_vf_mac_addr(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_SET_MULTICAST:
> +		retval =3D wx_set_vf_multicasts(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_SET_VLAN:
> +		retval =3D wx_set_vf_vlan_msg(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_SET_LPE:
> +		if (msgbuf[1] > WX_MAX_JUMBO_FRAME_SIZE) {
> +			wx_err(wx, "VF max_frame %d out of range\n",
> msgbuf[1]);
> +			return -EINVAL;
> +		}
> +		retval =3D wx_set_vf_lpe(wx, msgbuf[1], vf);
> +		break;
> +	case WX_VF_SET_MACVLAN:
> +		retval =3D wx_set_vf_macvlan_msg(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_API_NEGOTIATE:
> +		retval =3D wx_negotiate_vf_api(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_GET_QUEUES:
> +		retval =3D wx_get_vf_queues(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_GET_LINK_STATE:
> +		retval =3D wx_get_vf_link_state(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_GET_FW_VERSION:
> +		retval =3D wx_get_fw_version(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_UPDATE_XCAST_MODE:
> +		retval =3D wx_update_vf_xcast_mode(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_BACKUP:
> +		break;
> +	default:
> +		wx_err(wx, "Unhandled Msg %8.8x\n", msgbuf[0]);
> +		retval =3D -EBUSY;
> +		break;
> +	}
> +

Seems lot of functionality introduced in a single patch.
IMO it would better to split multicast, vlan etc into separate patches.

Thanks,
Sunil.

