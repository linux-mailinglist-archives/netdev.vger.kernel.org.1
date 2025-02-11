Return-Path: <netdev+bounces-165129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB53CA309AE
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 12:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA3F188B5E8
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413231FBE8D;
	Tue, 11 Feb 2025 11:15:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87931F417C
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272526; cv=none; b=PHJQGpX7kcca1OzGxhR+1RfCX9HLQ61DClWUS4rTdcKHo9poajGRUTdj+zDGI7trpKkBlqe5yf5bw7F13WhBJZnzHgTRfoUkICOVVvH9GS51Sf1VXkF9oY1gdN2mkX5gFd+ZRqxFKmYx8fApDRbLJxll2Mf/+rFrphUZJP6o8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272526; c=relaxed/simple;
	bh=LHemEMoW2QqciL82UVmk2u2J2dvnJEll3D6qgiwN0YM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Mw21T29NLZaQfBiI6b0ei4KKkBF7v0rDmMNultpF2estkJV3NZuN+C6luprRk58fyAlCVVXVCNHwEwCxvEJMvkAu4P3hC0eRTUc9gnf3xWyJKJttXOiqVwvq41doHJ2NniQZWoAL3kW9IOiSJhNWcreh+qhQNcdaF83hdBnMT1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp88t1739272492tmji8oy4
X-QQ-Originating-IP: 7wWH4VPrfkFiwqdJle54D9qhoMQ6XPRv8kiR9t4BmRY=
Received: from smtpclient.apple ( [183.157.104.65])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Feb 2025 19:14:50 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17477912342246512960
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH net-next v7 4/6] net: libwx: Add msg task func
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20250207171739.7ab11585@kernel.org>
Date: Tue, 11 Feb 2025 19:14:39 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <43A1F6A5-2F22-4A4B-ACAE-EEEC8A5B889A@net-swift.com>
References: <20250206103750.36064-1-mengyuanlou@net-swift.com>
 <20250206103750.36064-5-mengyuanlou@net-swift.com>
 <20250207171739.7ab11585@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MP1WLfctJNZWR/Pb4RAm+AFTl0UP4KaKhAgxZdn4PEbV1D7Yn9y79wX4
	/qj/cJAIaMjfEGuTqW38iNvFQ3GKyKdPt2D9nLRd3Tb4VUBYo6vOGPoWYu0zvCrxEQARX0/
	oZruK8jKQKRNI9C3OfC9sWCCG+WT2Wi5dPZKBZr24pvDhzqNpffwV7JM4SCweRBnBZLQaP5
	+uV4TcUbF7b1tota4/xfckEuniHYL2i3C3uS+tj/P6noCnXZb1ZunK5KqzF/65YsvaN3RAz
	ljFrTVc1oFvsWN6YrEpoupRmtlRmfYm+7QKN1TH1Ca9F+7D6R8KVNpKWtGO5odDEtKEzkr9
	3TbpBB+EajPC+7WubeCp9pGQmw6XvpVVPIewekMGTR2qBxTM64GIBOY9g14TKMLt34NTy54
	ceUdwyazu24BUbaxPT5xlkng7Njhh7OsGPDOA4QYF60NOawQBZF/1l9kyJkKRt8G1UT9FuN
	pGDuLhurDeBPPBCkVtHeGyqcrKkvO/UjSRi+xT5LRuFlqKGT7WhyjTv2GoSWcfTSCcxd4Tj
	9mVnvoXEcz20PGqFg/4BlrvS7q6N982oTKqt75B/6DdbGKulqS41QTnM5EIvQTeqEmhjW5m
	R23UWdNtjAl4/UOZTFl5RK/t+TokuV+4GzXPcSI7/8/rW36bAN993aa9+/6JdizfZOnV7vg
	8+4MtQgHS4wmJL3H+u//czI8d3hGn9AoAjThnI6BkaaxkZZC6wkE9PLKilqzI3YFN6LM6h3
	gIhuAQPk9aJVhIDeiSWtDBMzMSttljd9Y+MLY6xF3L4Gft/4sETCIg2D6Wh9w3ZO4qXwa3H
	wGirdfsJ0dIue9s6pC0JKknDnWFGdpxWoptxUyMXSt1ea9qgVdcHLA+4MHKvbGayBR90npc
	MxezzkYc91V/+GxFYf+CXxy25ZtDRyvR6TIM4+B2TnmxlHzdzS6BruCLttPIXTVP1dQSda7
	9HRVJ5W9DoHUsROmTiulvXoV+okCl0Vl/YQKNmc2jh/E3PvtHLxUB2yO/n1+ANWWUlxWpWk
	Z4zhGI4w==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B42=E6=9C=888=E6=97=A5 09:17=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu,  6 Feb 2025 18:37:48 +0800 mengyuanlou wrote:
>> +static int wx_negotiate_vf_api(struct wx *wx, u32 *msgbuf, u32 vf)
>> +{
>> + int api =3D msgbuf[1];
>> +
>> + switch (api) {
>> + case wx_mbox_api_10 ... wx_mbox_api_13:
>> + wx->vfinfo[vf].vf_api =3D api;
>> + return 0;
>> + default:
>> + wx_err(wx, "VF %d requested invalid api version %u\n", vf, api);
>> + return -EINVAL;
>> + }
>> +}
>=20
> How "compatible" is your device with IXGBE?
>=20

The pfvf mailbox flow is similar to IXGBE.
But compatibility with the previous api seems not to be required,
because inbox has been refactored.=20


> static int ixgbe_negotiate_vf_api(struct ixgbe_adapter *adapter,       =
        =20
>                                  u32 *msgbuf, u32 vf)                  =
       =20
> {                                                                      =
        =20
>        int api =3D msgbuf[1];                                          =
         =20
>=20
>        switch (api) {                                                  =
       =20
>        case ixgbe_mbox_api_10:                                         =
       =20
>        case ixgbe_mbox_api_11:                                         =
       =20
>        case ixgbe_mbox_api_12:                                         =
       =20
>        case ixgbe_mbox_api_13:                                         =
       =20
>        case ixgbe_mbox_api_14:                                         =
       =20
>                adapter->vfinfo[vf].vf_api =3D api;                     =
         =20
>                return 0;                                               =
       =20
>        default:                                                        =
       =20
>                break;                                                  =
       =20
>        }                                                               =
       =20
>=20
>        e_dbg(drv, "VF %d requested unsupported api version %u\n", vf, =
api);   =20
>=20
>        return -1;                                                      =
       =20
> }                                                                      =
        =20
>=20
>=20


