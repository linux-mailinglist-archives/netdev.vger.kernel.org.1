Return-Path: <netdev+bounces-16476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011D274D7D3
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 15:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43BE2812C1
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 13:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CFE125AD;
	Mon, 10 Jul 2023 13:35:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FB911C8F
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:35:20 +0000 (UTC)
Received: from mail1-1.quietfountain.com (mail1-1.quietfountain.com [192.190.136.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AB8103
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 06:35:14 -0700 (PDT)
Received: from mail1-1.quietfountain.com (localhost [127.0.0.1])
	by mail1-1.quietfountain.com (Postfix) with ESMTP id 4R04kS3DH3z5Ddtf
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 08:35:12 -0500 (CDT)
Authentication-Results: mail1-1.quietfountain.com (amavisd-new);
	dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
	header.d=quietfountain.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	quietfountain.com; h=content-transfer-encoding:content-type
	:organization:content-language:to:subject:from:user-agent
	:mime-version:date:message-id; s=dkim; t=1688996111; x=
	1691588112; bh=G1U4g39Xbdwbja9G2E/geulSEFuc3ZWabEhI5/XOuX4=; b=T
	gcfSNF2sSmTIIf5UJAov370BK6WWf08hagSPzzbLwXfzErXX4w6sSd/+7e4OPYrz
	1EpBIkBPmkp//L24R6cu9GuU+h9njhK413gzmsI8wrdz5RrWgiRFLi4gzJww6jcg
	zWF1vCDvo9RUefY0zNt8nBLzTNzIb2GbvzlEFqd3AxLaTDWFQCTRPHoQC2cUPzvZ
	RzXr7+2SWbhXm2QVg+0HeUf4E+kCV+X/qlgGcF3wyvqbT/0nM+C7ubzXDgpJQWr9
	oDDhIfk9Fr5cGwy22Rj3m2pKWhcZormPJ5LK81CbrOjOTDWkhx+w0fwIg4e7RsZi
	a3syZGtClLKa4SNF1H7jWRU7KmaxRc9YMPitDw0hVvE+Es1KhXfvDdlEXzXUUclz
	Nvipm7+zAC3Oehh3kr4gs7UblEBrwkpWwFgO8YrdAr9U8sQWrIL4gj7H4oxhERAi
	1EcikRyFprWIxrOH8sLmiJf9GNQL4X4aM/7P0MXKf54Zgsw3tDbVxQMTKX/JwGs9
	NBT5Sg8sAftxdNfKjVW9HwP7PcfKPh0ZEzOMKAjo2p06IBfjhtvHDgVF7u5hRh4v
	3493fg4HBFMP4xBPsWeUi5jZTVqYX40Zxq9CATZZdzyN0i2ysMA3xt3wS7q1etTb
	6gJ8jrEsQpvD4teQGSt9iEBJ1coAQNzXnXgCqzK1tY=
X-Virus-Scanned: Debian amavisd-new at email1.1.quietfountain.com
Received: from mail1-1.quietfountain.com ([127.0.0.1])
	by mail1-1.quietfountain.com (mail1-1.quietfountain.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Guhjem9fj74k for <netdev@vger.kernel.org>;
	Mon, 10 Jul 2023 08:35:11 -0500 (CDT)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from [10.12.114.193] (unknown [10.12.114.193])
	by mail1-1.quietfountain.com (Postfix) with ESMTPSA id 4R04kR3xPmz59k11
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 08:35:11 -0500 (CDT)
Message-ID: <608c37f9-34b1-85e6-2b4b-2a0389dd3d47@quietfountain.com>
Date: Mon, 10 Jul 2023 08:35:08 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Harry Coin <hcoin@quietfountain.com>
Subject: Patch fixing STP if bridge in non-default namespace.
To: netdev@vger.kernel.org
Content-Language: en-US
Organization: Quiet Fountain LLC / Rock Stable Systems
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Notice without access to link-level multicast address 01:80:C2:00:00:00,=20
the STP loop-avoidance feature of bridges fails silently, leading to=20
packet storms if loops exist in the related L2.=C2=A0 The Linux kernel's=20
latest code silently drops BPDU STP packets if the bridge is in a=20
non-default namespace.

The current llc_rcv.c around line 166 in net/llc/llc_input.c=C2=A0 has

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!net_eq(dev_net(dev), &init_net=
))
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0goto drop;

Which, when commented out, fixes this bug.=C2=A0 A search on &init_net ma=
y=20
reveal many similar artifacts left over from the early days of namespace=20
implementation.

Thanks for all you do!


--=20

