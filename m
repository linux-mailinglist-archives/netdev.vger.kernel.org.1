Return-Path: <netdev+bounces-231661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0EABFC1EC
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1850019A7B30
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E9A3074AD;
	Wed, 22 Oct 2025 13:25:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D6D26ED5E
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139500; cv=none; b=B6lCQgjNgU5uRshWVJ1LbOwOEY26uRYgvEe7FH9LE8AcgNKQtJPIHvQMqOXsbl9OB/ARLThGokDTbiLYFHY0PLlyb+P79PdFyhAsejdemwavAJBan6DbFFDXiF5hJCN1vTRslSWaEpoIDWn2a3EVATnOZPp5WS5GfJ8pkGrEB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139500; c=relaxed/simple;
	bh=MxOeva7sGE4JqDgflkaw4YcimnnYk7pmoAjXXsCHBGo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=clHMPCv5hUpWOymiPVEiFHHGTav5TfU8uYc9KWq5p1C0vwK2R+hPBFgnd0xCxX/f2sBB/xNyWqbmK7wdQ8Nf6Guzgy3/bYMWEKvvR5kMCUqPC8RlxzYSGo3KFGa/u0Kiem8tw0GXVomEXBjxLFB+Y2VUqOkNip8oFK+WpfqCJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz3t1761139452t87a8bda4
X-QQ-Originating-IP: K/yowfk6vRQuXCtIh5BaaZ37IzI3Xea0qW40L45Tilk=
Received: from smtpclient.apple ( [111.204.182.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Oct 2025 21:24:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16551395964960191803
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next] net: add the ifindex for
 trace_net_dev_xmit_timeout
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <aPi1z_frpBzpBPpa@shredder>
Date: Wed, 22 Oct 2025 21:23:58 +0800
Cc: Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org,
 Eran Ben Elisha <eranbe@mellanox.com>,
 Jiri Pirko <jiri@mellanox.com>,
 Cong Wang <xiyou.wangcong@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D522AB4-7864-4E5B-8B7C-F2DF01240314@bamaicloud.com>
References: <20251021091900.62978-1-tonghao@bamaicloud.com>
 <20251021171006.725400e3@kernel.org>
 <27169B5F-3269-4075-89F4-FA7459241EB3@bamaicloud.com>
 <aPi1z_frpBzpBPpa@shredder>
To: Ido Schimmel <idosch@idosch.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NmRamJ8ta5C5fooUbnN5hDPRGIcAte9vbSvp2c1HePInrp5VDeWE+w0M
	gTla81M9B7qLMD3+lZ9/6NxY6+K/JO7Wv1dq7cquWExAbawjUlPFmar4SEmyEOzbHw+uXOl
	yEl+azq2r0GBkIUsviWLz+Y3txzFtaBBEyFAN9o4obI5bAPifZuwW2Ni8CQU/RwOzmeoK2X
	8hEcHnoqcOA5ZJholFU/gWSKqtXMQD6g3LGqTXkveKhxvp3VsuVO34uWGOoAUyr2wX7gQuM
	xF0HWRIBeNgCOyXoIgRJPm+xfW+M0F0ljEjKpO/XOjRbZhKpZF31daooP5iXyO9HiafmHOP
	1EJjz/f/xMyvr5a/J10pZBM304qClIXzn8/Wu1Tpk9rcgsb3UxSAExQhBjqEh/F4SdDKRO1
	BpBj675mZNr8Os87Bm+vah6ZTe1Marb7daoX2GiZgfqlHAiemqXEmSHun5UfV8+6pbwHLVl
	j6ggmBUIRO4s0L7yU/VNw/k2tDTFoVf2Sr5miG0YAXudpI9cLVjSPeeFyeERk+55iISU/nx
	1smsP3FjIZu+7ZbjY/+oVy4D+MfVYF2YuvGT+E5J/0RHKlxL1EBVGOTHKQLpqGFhoU/kXvM
	8FsJRacoeBli1xMuH9K7NGF5sNvz0A13kEOxUDftq87T1QbuRZMHRQHT/KzCrVRkU5zZAAO
	G7vcwyp7FIIu3p37hYxlyjDJZDyq0eMHiaKpj333K67UQWN7+I17+VTqYJjQKm5/bQf5vuj
	QHsQU9+OyTDld0g43kHPEHFWiBjpZUxdBaS1w/aufMRO1yKpePr9z/gwrskuSgyMdnUZaoo
	Wr8b6ElxEExEmrZbQ0l7rK6ss/0w8qtxvU/gdV3szyfSc9dQltVW6DFTZ7Xxzc+0yXif+ee
	7AUT/q9iYVLwiWnuk1N+2QCfgAueusduQHhedmLKtf+4PgfFyt4hbym01iVAIRwABG7u3L+
	cQXL+lgSY/22xLB+qqJrCyhY0wyF2YRjMxf4AjrzRymkpOQg4jJ84D0JP4Pm5KnwzioU=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0



> On Oct 22, 2025, at 18:45, Ido Schimmel <idosch@idosch.org> wrote:
>=20
> On Wed, Oct 22, 2025 at 04:31:34PM +0800, Tonghao Zhang wrote:
>>> On Oct 22, 2025, at 08:10, Jakub Kicinski <kuba@kernel.org> wrote:
>>>=20
>>> On Tue, 21 Oct 2025 17:19:00 +0800 Tonghao Zhang wrote:
>>>> In a multi-network card or container environment, provide more =
accurate information.
>>>=20
>>> Why do you think that ifindex is more accurate than the name?
>>> Neither is unique with netns..
>> I thought ifindex was globally unique, but in fact, different =
namespaces may have the same ifindex value. What about adding the =
ns.inum inode ?
>=20
> The netns cookie is probably better. See this thread:
>=20
> =
https://lore.kernel.org/netdev/c28ded3224734ca62187ed9a41f7ab39ceecb610.ca=
mel@fejes.dev/
That's a good idea, it's helpful to me.
>=20
> You can also retrieve it by attaching a BPF program to the tracepoint.
>=20


