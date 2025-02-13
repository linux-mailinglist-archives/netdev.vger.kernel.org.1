Return-Path: <netdev+bounces-165770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1E9A3355C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 03:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6E9163965
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848AC146588;
	Thu, 13 Feb 2025 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="TUja99Yr"
X-Original-To: netdev@vger.kernel.org
Received: from lf-1-18.ptr.blmpb.com (lf-1-18.ptr.blmpb.com [103.149.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B927C14B95A
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 02:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412801; cv=none; b=QTey7kkfK9Z96tTJs2RRB/tn2HxKCJNwhxal91I6i1ueJEx8CQnrQTdDn01sOQaRJFzHhG7H5eiuCDU5V8JlHaiPrjRnSEt4BJsgzF7eBfOB02wV+aCD8tUyZ9mXghmzq/AMMb/f521Ssbo189nFX5FtK68ubRr17nirEUbwlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412801; c=relaxed/simple;
	bh=qY4OuK52CJ/hozEdcX+vM/noott++9Wph5BY858UhbM=;
	h=Cc:Subject:Date:Mime-Version:In-Reply-To:References:To:Message-Id:
	 Content-Type:From; b=pRPEB+imZCbPjMKW7lGSdM3IsLV5uTb6dOO8E3XHnmSApWK3D5tMv+2DRx61/7tqpsrgLnJDGB7N0Zi/NgQS5VWDhAi8ensTrBfpF3D69PKHu6wKKzSceubPMNqRQBoZsg3+R52IH/Ze++CYboPMhddZj5O2423XDtK4v2ORTK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=TUja99Yr; arc=none smtp.client-ip=103.149.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1739412579; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=qY4OuK52CJ/hozEdcX+vM/noott++9Wph5BY858UhbM=;
 b=TUja99YrHs1h/bRApq7Qm3JS24GziXhXuWqw0j6pUhIULoU7/FW3SpUFyDEdoISJrAxirN
 5zBMJgSCue9RoUsU/bz54FyfwI6zGjNbjP42o4lr9tuEM7V4XUgP3CGkOjOkdJCMbxrAEC
 J9hWcPneMm0JKck496GdsuDL9HTawKqU75iByLKZ2lV8n3dIiGkcUCmmhMhxEl10JLjHn1
 h3PXwcazv+1zJb5Nx5gNY6nz6/6MKk9qIFh8TiIg1CDARRwgHggONZwgjp9Q3smYCRISl7
 GFvFP4ItBPvHhobaeZE6TfQkuuhrbgXo68y1iGKT2+Wo2HffKJwDCIlcbKRsCQ==
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <weihg@yunsilicon.com>, 
	<wanry@yunsilicon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 02/14] net-next/yunsilicon: Enable CMDQ
Date: Thu, 13 Feb 2025 10:09:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: tianx <tianx@yunsilicon.com>
In-Reply-To: <0cf7fbc3-acc3-4178-bc3b-bd35cde1cafb@intel.com>
X-Lms-Return-Path: <lba+267ad5461+a6ccf9+vger.kernel.org+tianx@yunsilicon.com>
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Thu, 13 Feb 2025 10:09:35 +0800
References: <20250115102242.3541496-1-tianx@yunsilicon.com> <20250115102245.3541496-3-tianx@yunsilicon.com> <0cf7fbc3-acc3-4178-bc3b-bd35cde1cafb@intel.com>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
To: "Przemek Kitszel" <przemyslaw.kitszel@intel.com>
Message-Id: <185731c2-30c7-4199-b215-21ac215811eb@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
From: "tianx" <tianx@yunsilicon.com>

On 2025/1/16 18:30, Przemek Kitszel wrote:
> On 1/15/25 11:22, Xin Tian wrote:
>> Enable cmd queue to support driver-firmware communication.
>> Hardware control will be performed through cmdq mostly.
>>
>
> I didn't checked, but plese don't include anything that would not
> be used at the end of the series. IOW: no dead code.
>
> > +=C2=A0=C2=A0=C2=A0 XSC_HW_THIRD_FEATURE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D BIT(2),
> really? :D
>
thank you, that's an unused flag, will be removed.
> [..]
>
>
>> +=C2=A0=C2=A0=C2=A0 __be64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 com=
plete_reg;
>> +=C2=A0=C2=A0=C2=A0 __be64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eve=
nt_db;
>> +=C2=A0=C2=A0=C2=A0 __be32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp_=
rate_limit_min;
>> +=C2=A0=C2=A0=C2=A0 __be32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp_=
rate_limit_max;
>> +=C2=A0=C2=A0=C2=A0 struct xsc_fw_version=C2=A0 fw_ver;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0 lag_logic_port_ofst;
>> +};
>> +
>> +struct xsc_cmd_query_hca_cap_mbox_in {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_inbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 __be16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cpu_num;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rsvd[6];
>> +};
>> +
>> +struct xsc_cmd_query_hca_cap_mbox_out {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_outbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rsvd0[8];
>> +=C2=A0=C2=A0=C2=A0 struct xsc_hca_cap=C2=A0=C2=A0=C2=A0 hca_cap;
>> +};
>> +
>> +struct xsc_query_vport_state_out {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_outbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>
> this is BE
>
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 admin_state:4;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 state:4;
>> +};
>> +
>> +struct xsc_query_vport_state_in {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_inbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>
> this is BE
>
>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 other_vport:1;
>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 vport_number:16;
>> +=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rsvd0:15;
>
> and this is CPU order, why?

Thanks, that's a mistake, I will standardize it to big-endian.

>
>> +};
>> +
>> +enum {
>> +=C2=A0=C2=A0=C2=A0 XSC_CMD_EVENT_RESP_CHANGE_LINK=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D BIT(0),
>> +=C2=A0=C2=A0=C2=A0 XSC_CMD_EVENT_RESP_TEMP_WARN=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D BIT(1),
>> +=C2=A0=C2=A0=C2=A0 XSC_CMD_EVENT_RESP_OVER_TEMP_PROTECTION=C2=A0=C2=A0=
=C2=A0 =3D BIT(2)
>
> (always add comma at the end, unless the entry is supposed
> to be last forever)
>
OK
>> +};
>> +
>> +struct xsc_event_resp {
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 resp_cmd_type;
>> +};
>> +
>> +struct xsc_event_query_type_mbox_in {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_inbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rsvd[2];
>> +};
>> +
>> +struct xsc_event_query_type_mbox_out {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_outbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 struct xsc_event_resp=C2=A0=C2=A0=C2=A0 ctx;
>> +};
>> +
>> +struct xsc_modify_raw_qp_request {
>> +=C2=A0=C2=A0=C2=A0 u16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qpn;
>
> hard to tell why you have switched from BE to CPU order
> at this point
>
As explained above.
>> +=C2=A0=C2=A0=C2=A0 u16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lag_id=
;
>> +=C2=A0=C2=A0=C2=A0 u16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 func_i=
d;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_dir=
ect;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prio;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp_out_=
port;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rsvd[7]=
;
>> +};
>> +
>> +struct xsc_modify_raw_qp_mbox_in {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_inbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pcie_no;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rsvd[7];
>> +=C2=A0=C2=A0=C2=A0 struct xsc_modify_raw_qp_request=C2=A0=C2=A0=C2=A0 r=
eq;
>> +};
>> +
>> +struct xsc_modify_raw_qp_mbox_out {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_outbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rsvd[8];
>> +};
>> +
>> +struct xsc_set_mtu_mbox_in {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_inbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 __be16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mtu;
>> +=C2=A0=C2=A0=C2=A0 __be16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 rx_buf_sz_min;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mac_port;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rsvd;
>> +};
>> +
>> +struct xsc_set_mtu_mbox_out {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_outbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +};
>> +
>> +struct xsc_query_eth_mac_mbox_in {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_inbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 index;
>> +};
>> +
>> +struct xsc_query_eth_mac_mbox_out {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_outbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mac[6];
>
> ETH_ALEN
>
OK
>> +};
>> +
>> +enum {
>> +=C2=A0=C2=A0=C2=A0 XSC_TBM_CAP_HASH_PPH =3D 0,
>> +=C2=A0=C2=A0=C2=A0 XSC_TBM_CAP_RSS,
>> +=C2=A0=C2=A0=C2=A0 XSC_TBM_CAP_PP_BYPASS,
>> +=C2=A0=C2=A0=C2=A0 XSC_TBM_CAP_PCT_DROP_CONFIG,
>> +};
>> +
>> +struct xsc_nic_attr {
>> +=C2=A0=C2=A0=C2=A0 __be16=C2=A0=C2=A0=C2=A0 caps;
>> +=C2=A0=C2=A0=C2=A0 __be16=C2=A0=C2=A0=C2=A0 caps_mask;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0 mac_addr[6];
>> +};
>> +
>> +struct xsc_rss_attr {
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0 rss_en;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0 hfunc;
>> +=C2=A0=C2=A0=C2=A0 __be16=C2=A0=C2=A0=C2=A0 rqn_base;
>> +=C2=A0=C2=A0=C2=A0 __be16=C2=A0=C2=A0=C2=A0 rqn_num;
>> +=C2=A0=C2=A0=C2=A0 __be32=C2=A0=C2=A0=C2=A0 hash_tmpl;
>> +};
>> +
>> +struct xsc_cmd_enable_nic_hca_mbox_in {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_inbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 struct xsc_nic_attr=C2=A0=C2=A0=C2=A0 nic;
>> +=C2=A0=C2=A0=C2=A0 struct xsc_rss_attr=C2=A0=C2=A0=C2=A0 rss;
>> +};
>> +
>> +struct xsc_cmd_enable_nic_hca_mbox_out {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_outbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rsvd0[2];
>> +};
>> +
>> +struct xsc_nic_dis_attr {
>> +=C2=A0=C2=A0=C2=A0 __be16=C2=A0=C2=A0=C2=A0 caps;
>> +};
>> +
>> +struct xsc_cmd_disable_nic_hca_mbox_in {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_inbox_hdr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 struct xsc_nic_dis_attr=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 nic;
>> +};
>> +
>> +struct xsc_cmd_disable_nic_hca_mbox_out {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_outbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rsvd0[4];
>> +};
>> +
>> +struct xsc_function_reset_mbox_in {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_inbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 __be16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 glb_func_id;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rsvd[6];
>> +};
>> +
>> +struct xsc_function_reset_mbox_out {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_outbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rsvd[8];
>> +};
>> +
>> +struct xsc_cmd_query_guid_mbox_in {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_inbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rsvd[8];
>> +};
>> +
>> +struct xsc_cmd_query_guid_mbox_out {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_outbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 __be64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 guid;
>> +};
>> +
>> +struct xsc_cmd_activate_hw_config_mbox_in {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_inbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rsvd[8];
>> +};
>> +
>> +struct xsc_cmd_activate_hw_config_mbox_out {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_outbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rsvd[8];
>> +};
>> +
>> +struct xsc_event_set_port_admin_status_mbox_in {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_inbox_hdr=C2=A0=C2=A0=C2=A0 hdr;
>> +=C2=A0=C2=A0=C2=A0 u16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 admin_status;
>
> reapeating "admin" in the "admin" command seems redundant
>
got it
> [..]
>
>> +struct xsc_cmd {
>> +=C2=A0=C2=A0=C2=A0 struct xsc_cmd_reg reg;
>> +=C2=A0=C2=A0=C2=A0 void=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 *cmd_buf;
>> +=C2=A0=C2=A0=C2=A0 void=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 *cq_buf;
>> +=C2=A0=C2=A0=C2=A0 dma_addr_t=C2=A0=C2=A0=C2=A0 dma;
>> +=C2=A0=C2=A0=C2=A0 dma_addr_t=C2=A0=C2=A0=C2=A0 cq_dma;
>> +=C2=A0=C2=A0=C2=A0 u16=C2=A0=C2=A0=C2=A0=C2=A0 cmd_pid;
>> +=C2=A0=C2=A0=C2=A0 u16=C2=A0=C2=A0=C2=A0=C2=A0 cq_cid;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 owner_bit;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmdif_r=
ev;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_sz;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_str=
ide;
>> +=C2=A0=C2=A0=C2=A0 int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_re=
g_cmds;
>> +=C2=A0=C2=A0=C2=A0 int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 events=
;
>> +=C2=A0=C2=A0=C2=A0 u32 __iomem=C2=A0=C2=A0=C2=A0 *vector;
>> +
>> +=C2=A0=C2=A0=C2=A0 spinlock_t=C2=A0=C2=A0=C2=A0 alloc_lock;=C2=A0=C2=A0=
=C2=A0 /* protect command queue=20
>> allocations */
>> +=C2=A0=C2=A0=C2=A0 spinlock_t=C2=A0=C2=A0=C2=A0 token_lock;=C2=A0=C2=A0=
=C2=A0 /* protect token allocations */
>> +=C2=A0=C2=A0=C2=A0 spinlock_t=C2=A0=C2=A0=C2=A0 doorbell_lock;=C2=A0=C2=
=A0=C2=A0 /* protect cmdq req pid doorbell */
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 token;
>
> you have a whole lock for token allocations, but then there is a field
> named @token, what it does?
>
the |token| field is used to generate and maintain a unique identifier=20
for commands:

token =3D cmd->token++ % 255 + 1;

It is protected by the token_lock

>> +=C2=A0=C2=A0=C2=A0 unsigned long=C2=A0=C2=A0=C2=A0 bitmask;
>
> again, this name is so generic, that only "data" is less generic
> BTW see DECLARE_BITMAP()
Is cmd_entry_mask better? it's a bitmap recording used cmd entry.
>
>> +=C2=A0=C2=A0=C2=A0 char wq_name[XSC_CMD_WQ_MAX_NAME];
>> +=C2=A0=C2=A0=C2=A0 struct workqueue_struct *wq;
>
> sorry if I have already asked you, do you really need custom WQ instead
> of just using one of the kernel ones?
>
we cannot use one of the kernel's standard workqueues, because we need=20
to ensure that the commands are executed in the exact order they are=20
issued. Therefore, we must use a single-threaded workqueue to maintain=20
the execution sequence.
>> +=C2=A0=C2=A0=C2=A0 struct task_struct *cq_task;
>> +=C2=A0=C2=A0=C2=A0 struct semaphore sem;
>
> please write a documentation of how it is used

ok, The semaphore limits the number of working commands to |max_reg_cmds|.

Each |exec_cmd| call does a |down| to acquire the semaphore before=20
execution and an |up| after completion, ensuring no more than=20
|max_reg_cmds| commands run at the same time.

>
>> +=C2=A0=C2=A0=C2=A0 int=C2=A0=C2=A0=C2=A0 mode;
>
> you could just embed an enum here, same size
OK, will modify
>
>> +=C2=A0=C2=A0=C2=A0 struct xsc_cmd_work_ent *ent_arr[XSC_MAX_COMMANDS];
>> +=C2=A0=C2=A0=C2=A0 struct dma_pool *pool;
>> +=C2=A0=C2=A0=C2=A0 struct xsc_cmd_debug dbg;
>> +=C2=A0=C2=A0=C2=A0 struct cmd_msg_cache cache;
>> +=C2=A0=C2=A0=C2=A0 int checksum_disabled;
>> +=C2=A0=C2=A0=C2=A0 struct xsc_cmd_stats stats[XSC_CMD_OP_MAX];
>> +=C2=A0=C2=A0=C2=A0 unsigned int=C2=A0=C2=A0=C2=A0 irqn;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0 ownerbit_learned;
>> +=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0=C2=A0 cmd_status;
>> +};
>> +
>> +#endif
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h=20
>> b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> index 2c4e8e731..3b4b77948 100644
>> --- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
>> @@ -8,6 +8,7 @@
>> =C2=A0 =C2=A0 #include <linux/kernel.h>
>
> (sorry for commenting in the wrong patch)
>
> you should avoid including kernel.h
> (include what you use IWYU, kernel.h is a historic header
> with much baggage, don't inclde if not strictly needed)
>
got it
>> =C2=A0 #include <linux/pci.h>
>
> separate "header groups" by a blank line
good suggestion.
>
>> +#include "common/xsc_cmdq.h"
>> =C2=A0 =C2=A0 #define XSC_PCI_VENDOR_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x1f67
>> =C2=A0 @@ -26,6 +27,11 @@
>> =C2=A0 #define XSC_MV_HOST_VF_DEV_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1152
>> =C2=A0 #define XSC_MV_SOC_PF_DEV_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1153
>> =C2=A0 +#define REG_ADDR(dev, offset)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>
> no need to put "\" so far to the right
> remainder about xsc prefix
>
OK
>> +=C2=A0=C2=A0=C2=A0 (((dev)->bar) + ((offset) - 0xA0000000))
>> +
>> +#define REG_WIDTH_TO_STRIDE(width)=C2=A0=C2=A0=C2=A0 ((width) / 8)
>> +
>> =C2=A0 struct xsc_dev_resource {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mutex alloc_mutex;=C2=A0=C2=A0=C2=
=A0 /* protect buffer alocation=20
>> according to numa node */
>> =C2=A0 };
>> @@ -35,6 +41,10 @@ enum xsc_pci_state {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XSC_PCI_STATE_ENABLED,
>> =C2=A0 };
>> =C2=A0 +enum xsc_interface_state {
>> +=C2=A0=C2=A0=C2=A0 XSC_INTERFACE_STATE_UP =3D BIT(0),
>> +};
>> +
>> =C2=A0 struct xsc_core_device {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 *pdev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 *device;
>> @@ -44,6 +54,9 @@ struct xsc_core_device {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void __iomem=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 *bar;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bar_num;
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 struct xsc_cmd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 cmd;
>> +=C2=A0=C2=A0=C2=A0 u16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cmdq_ver;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mutex=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pci_state_mutex;=C2=A0=C2=A0=C2=A0 /* protect pci_state */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum xsc_pci_state=C2=A0=C2=A0=C2=A0 pci_=
state;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mutex=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 intf_state_mutex;=C2=A0=C2=A0=C2=A0 /* protect intf_state *=
/
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h=20
>> b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h
>> new file mode 100644
>> index 000000000..72b2df6c9
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h
>> @@ -0,0 +1,25 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> + * All rights reserved.
>> + */
>> +
>> +#ifndef __XSC_DRIVER_H
>> +#define __XSC_DRIVER_H
>> +
>> +#include "common/xsc_core.h"
>> +#include "common/xsc_cmd.h"
>> +
>> +int xsc_cmd_init(struct xsc_core_device *xdev);
>> +void xsc_cmd_cleanup(struct xsc_core_device *xdev);
>> +void xsc_cmd_use_events(struct xsc_core_device *xdev);
>> +void xsc_cmd_use_polling(struct xsc_core_device *xdev);
>> +int xsc_cmd_err_handler(struct xsc_core_device *xdev);
>> +void xsc_cmd_resp_handler(struct xsc_core_device *xdev);
>> +int xsc_cmd_status_to_err(struct xsc_outbox_hdr *hdr);
>> +int xsc_cmd_exec(struct xsc_core_device *xdev, void *in, int=20
>> in_size, void *out,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int out_size);
>> +int xsc_cmd_version_check(struct xsc_core_device *xdev);
>> +const char *xsc_command_str(int command);
>> +
>> +#endif
>> +
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile=20
>> b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>> index 709270df8..5e0f0a205 100644
>> --- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
>> @@ -6,4 +6,4 @@ ccflags-y +=3D=20
>> -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
>> =C2=A0 =C2=A0 obj-$(CONFIG_YUNSILICON_XSC_PCI) +=3D xsc_pci.o
>> =C2=A0 -xsc_pci-y :=3D main.o
>> +xsc_pci-y :=3D main.o cmdq.o
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c=20
>> b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
>> new file mode 100644
>> index 000000000..028970151
>> --- /dev/null
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
>> @@ -0,0 +1,1555 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>> +/*
>> + * Copyright (c) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
>> + * All rights reserved.
>> + * Copyright (c) 2013-2016, Mellanox Technologies. All rights reserved.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>
> nope, you are either a module-like or builtin-only, remove init.h
OK
>
>> +#include <linux/errno.h>
>> +#include <linux/pci.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/slab.h>
>> +#include <linux/delay.h>
>> +#include <linux/random.h>
>> +#include <linux/kthread.h>
>> +#include <linux/io-mapping.h>
>> +#include "common/xsc_driver.h"
>> +#include "common/xsc_cmd.h"
>> +#include "common/xsc_auto_hw.h"
>> +#include "common/xsc_core.h"
>> +
>> +enum {
>> +=C2=A0=C2=A0=C2=A0 CMD_IF_REV =3D 3,
>> +};
>> +
>> +enum {
>> +=C2=A0=C2=A0=C2=A0 CMD_MODE_POLLING,
>> +=C2=A0=C2=A0=C2=A0 CMD_MODE_EVENTS
>> +};
>> +
>> +enum {
>> +=C2=A0=C2=A0=C2=A0 NUM_LONG_LISTS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 2,
>> +=C2=A0=C2=A0=C2=A0 NUM_MED_LISTS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 64,
>> +=C2=A0=C2=A0=C2=A0 LONG_LIST_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D (2U=
LL * 1024 * 1024 * 1024 / PAGE_SIZE) *=20
>> 8 + 16 +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 XSC_CMD_DATA_BLOCK_SIZE,
>> +=C2=A0=C2=A0=C2=A0 MED_LIST_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 16 +=
 XSC_CMD_DATA_BLOCK_SIZE,
>> +};
>> +
>> +enum {
>> +=C2=A0=C2=A0=C2=A0 XSC_CMD_DELIVERY_STAT_OK=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x0,
>> +=C2=A0=C2=A0=C2=A0 XSC_CMD_DELIVERY_STAT_SIGNAT_ERR=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x1,
>> +=C2=A0=C2=A0=C2=A0 XSC_CMD_DELIVERY_STAT_TOK_ERR=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x2,
>> +=C2=A0=C2=A0=C2=A0 XSC_CMD_DELIVERY_STAT_BAD_BLK_NUM_ERR=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x3,
>> +=C2=A0=C2=A0=C2=A0 XSC_CMD_DELIVERY_STAT_OUT_PTR_ALIGN_ERR=C2=A0=C2=A0=
=C2=A0 =3D 0x4,
>> +=C2=A0=C2=A0=C2=A0 XSC_CMD_DELIVERY_STAT_IN_PTR_ALIGN_ERR=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x5,
>> +=C2=A0=C2=A0=C2=A0 XSC_CMD_DELIVERY_STAT_FW_ERR=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x6,
>> +=C2=A0=C2=A0=C2=A0 XSC_CMD_DELIVERY_STAT_IN_LENGTH_ERR=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x7,
>> +=C2=A0=C2=A0=C2=A0 XSC_CMD_DELIVERY_STAT_OUT_LENGTH_ERR=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x8,
>> +=C2=A0=C2=A0=C2=A0 XSC_CMD_DELIVERY_STAT_RES_FLD_NOT_CLR_ERR=C2=A0=C2=
=A0=C2=A0 =3D 0x9,
>> +=C2=A0=C2=A0=C2=A0 XSC_CMD_DELIVERY_STAT_CMD_DESCR_ERR=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x10,
>> +};
>> +
>> +static struct xsc_cmd_work_ent *alloc_cmd(struct xsc_cmd *cmd,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct xsc_cmd_ms=
g *in,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct xsc_rsp_ms=
g *out)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct xsc_cmd_work_ent *ent;
>> +
>> +=C2=A0=C2=A0=C2=A0 ent =3D kzalloc(sizeof(*ent), GFP_KERNEL);
>> +=C2=A0=C2=A0=C2=A0 if (!ent)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(-ENOMEM);
>> +
>> +=C2=A0=C2=A0=C2=A0 ent->in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D in;
>> +=C2=A0=C2=A0=C2=A0 ent->out=C2=A0=C2=A0=C2=A0 =3D out;
>> +=C2=A0=C2=A0=C2=A0 ent->cmd=C2=A0=C2=A0=C2=A0 =3D cmd;
>> +
>> +=C2=A0=C2=A0=C2=A0 return ent;
>> +}
>> +
>> +static u8 alloc_token(struct xsc_cmd *cmd)
>
> remainted about xsc prefix in the names
>
>> +{
>> +=C2=A0=C2=A0=C2=A0 u8 token;
>> +
>> +=C2=A0=C2=A0=C2=A0 spin_lock(&cmd->token_lock);
>> +=C2=A0=C2=A0=C2=A0 token =3D cmd->token++ % 255 + 1;
>
> token=3D=3D0 is wrong or reserved?
it's reserved
>
>> +=C2=A0=C2=A0=C2=A0 spin_unlock(&cmd->token_lock);
>> +
>> +=C2=A0=C2=A0=C2=A0 return token;
>> +}
>> +
>> +static int alloc_ent(struct xsc_cmd *cmd)
>> +{
>> +=C2=A0=C2=A0=C2=A0 unsigned long flags;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&cmd->alloc_lock, flags);
>> +=C2=A0=C2=A0=C2=A0 ret =3D find_first_bit(&cmd->bitmask, cmd->max_reg_c=
mds);
>> +=C2=A0=C2=A0=C2=A0 if (ret < cmd->max_reg_cmds)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clear_bit(ret, &cmd->bitmask=
);
>> +=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&cmd->alloc_lock, flags);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret < cmd->max_reg_cmds ? ret : -ENOMEM;
>
> ENOMEM is strictly for kmalloc() family failures, perhaps ENOSPC?
>
will use ENOSPC
>> +}
>> +
>> +static void free_ent(struct xsc_cmd *cmd, int idx)
>> +{
>> +=C2=A0=C2=A0=C2=A0 unsigned long flags;
>> +
>> +=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&cmd->alloc_lock, flags);
>> +=C2=A0=C2=A0=C2=A0 set_bit(idx, &cmd->bitmask);
>> +=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&cmd->alloc_lock, flags);
>> +}
>> +
>> +static struct xsc_cmd_layout *get_inst(struct xsc_cmd *cmd, int idx)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return cmd->cmd_buf + (idx << cmd->log_stride);
>> +}
>> +
>> +static struct xsc_rsp_layout *get_cq_inst(struct xsc_cmd *cmd, int idx)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return cmd->cq_buf + (idx << cmd->log_stride);
>> +}
>> +
>> +static u8 xor8_buf(void *buf, int len)
>
> double check if there is already something like this in the kernel
>
Sorry, I couldn't find one like this in the kernel.
>> +{
>> +=C2=A0=C2=A0=C2=A0 u8 *ptr =3D buf;
>> +=C2=A0=C2=A0=C2=A0 u8 sum =3D 0;
>> +=C2=A0=C2=A0=C2=A0 int i;
>> +
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < len; i++)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sum ^=3D ptr[i];
>> +
>> +=C2=A0=C2=A0=C2=A0 return sum;
>> +}
>> +
>> +static int verify_block_sig(struct xsc_cmd_prot_block *block)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (xor8_buf(block->rsvd0, sizeof(*block) - sizeof(b=
lock->data)=20
>> - 1) !=3D 0xff)
>
> you force rsvd0 to be 0xff? the usual approach is that reserved fields
> are 0
> if this is somethins that your FW/HW already has baked in, please add
> a comment at this particular rsvd0 declaration
>
Yes, It's set to 0xff in the fw, and I'll add a comment.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (xor8_buf(block, sizeof(*block)) !=3D 0xff)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static void calc_block_sig(struct xsc_cmd_prot_block *block, u8 token)
>> +{
>> +=C2=A0=C2=A0=C2=A0 block->token =3D token;
>> +=C2=A0=C2=A0=C2=A0 block->ctrl_sig =3D ~xor8_buf(block->rsvd0, sizeof(*=
block) -=20
>> sizeof(block->data) - 2);
>> +=C2=A0=C2=A0=C2=A0 block->sig =3D ~xor8_buf(block, sizeof(*block) - 1);
>> +}
>> +
>> +static void calc_chain_sig(struct xsc_cmd_mailbox *head, u8 token)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct xsc_cmd_mailbox *next =3D head;
>> +
>> +=C2=A0=C2=A0=C2=A0 while (next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 calc_block_sig(next->buf, to=
ken);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next =3D next->next;
>> +=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> +static void set_signature(struct xsc_cmd_work_ent *ent)
>> +{
>> +=C2=A0=C2=A0=C2=A0 ent->lay->sig =3D ~xor8_buf(ent->lay, sizeof(*ent->l=
ay));
>> +=C2=A0=C2=A0=C2=A0 calc_chain_sig(ent->in->next, ent->token);
>> +=C2=A0=C2=A0=C2=A0 calc_chain_sig(ent->out->next, ent->token);
>> +}
>> +
>> +static void free_cmd(struct xsc_cmd_work_ent *ent)
>
> please move near the "alloc_cmd"
> remainder about the xsc prefixes
>
got it
> [...]
>
>> +
>> +static void cmd_work_handler(struct work_struct *work)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct xsc_cmd_work_ent *ent =3D container_of(work, =
struct=20
>> xsc_cmd_work_ent, work);
>> +=C2=A0=C2=A0=C2=A0 struct xsc_cmd *cmd =3D ent->cmd;
>
> reverse xmass tree violated
>
ok
>> +=C2=A0=C2=A0=C2=A0 struct xsc_core_device *xdev =3D container_of(cmd, s=
truct=20
>> xsc_core_device, cmd);

