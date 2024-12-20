Return-Path: <netdev+bounces-153842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4359F9CDD
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 23:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A64188981E
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B96421E08B;
	Fri, 20 Dec 2024 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="vT5ZOfDM"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D081C175C
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734735585; cv=none; b=mlF1hfOmvh0Iwna4DqwYponLkQHCXRWvt8GHz8I7Rdy4o5RWWWnH2JbYxHWm7wETw+NsSzGToXo4lX6xytSg34RMQtp4J+lGMcH9A9JeFEPqDgGzyrcSazai6lm4wcmewRPm/xjrq6adrM3UTX/pVJ+aFfpQP/4+LQLSogPjBYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734735585; c=relaxed/simple;
	bh=+41pCOzIdQnRhJNSpGyTdHhJPQxWf92wuJn9u5kXzRc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mOYPp4NPEqe4tlwupJmW1Agdy045EH78Fexrzkul2KFOjwjP7EVEWxWjawCKrkRgXhlgSWlhyE7rMVtBJ4YYqmvuqulPN0kLjfpvmW6Loddg3Qm/0VWg6yO+tMKdY4f6mOOb3LiLMNhk+TNfn6ThG5AYWb637d9LeGhs5VbNjV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=vT5ZOfDM; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 4BKMxZrs029455
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 Dec 2024 22:59:38 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 4BKMxZrs029455
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1734735580; bh=+41pCOzIdQnRhJNSpGyTdHhJPQxWf92wuJn9u5kXzRc=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=vT5ZOfDM55Du5tjMnfmbbQLqMPEqro85PfLQbfF70CcL0wLesx2UrhH+yoYd2DzNV
	 zxRObOt+S4WU2F5ph+MBQ1xi2+jlWR6ran86YoGVgayFHbPRB9Kz3s3TfBj0UVkPcD
	 QQn2Qwfr1FCbHzODrkquN5MJvjtj8/k0bRMbEWvU43vhSaK44muuNqP9iKG7dq2/Qh
	 0Ip4/fI/aeR994ywyPAFAK31NQDC1fs+WcVua6Fh3SjCDUFW4gOcVnG1BtjfYf8fqp
	 YaEu+BbJJCU9fZDyevSTQF6B3V29sQ3+GMaWxkabhoV+crpozVap5HWjj4MfuBrtsA
	 sikZwYSWQBQrw==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: net: dsa: mv88e6xxx architecture
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20241220225432.jsgw35gq3ejp57va@skbuf>
Date: Sat, 21 Dec 2024 09:59:25 +1100
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Kieran Tyrrell <kieran@sienda.com>, Max Hunter <max@huntershome.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA0551C1-9EA6-416C-8515-1F47C3599B0B@padl.com>
References: <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
 <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
 <20241220121010.kkvmb2z2dooef5it@skbuf>
 <7E1DC313-33DE-4AA8-AD52-56316C07ABC4@padl.com>
 <20241220225432.jsgw35gq3ejp57va@skbuf>
To: Vladimir Oltean <olteanv@gmail.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)


>> The catch is what to do with frames that share a priority with an AVB
>> class but are not negotiated by SRP. These frames could crowd out
>> frames from AVB streams. Marvell=E2=80=99s solution is a flag in the =
ATU which
>> indicates that the DA was added by SRP.
>=20
> Can you please state in a vendor-agnostic way what does the switch do
> with that information, how does it treat those streams specially?

Frames that are part of a stream (as identified by DA, VID and PCP) =
egress through designated priority queues.

Frames that are not part of a stream, but otherwise have a matching =
priority, can be discarded or have their priority remarked.=

