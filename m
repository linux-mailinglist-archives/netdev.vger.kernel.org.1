Return-Path: <netdev+bounces-196397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063C6AD4783
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 02:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DB63A8988
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 00:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDB217597;
	Wed, 11 Jun 2025 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="RXgz1jr+"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3C15E96
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 00:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749602198; cv=none; b=i9uQCOgdT7cfgsipiZwA3a5p+sRF/Zd1BIoTpEqc45tAuaaeiSrXnXI+YTVXVrljXrK2rRfiG0rOB4BnquZdlVzc49ZYGTbOre4wH0xCs3kgxh6ldSQLPBQERva5JFkzfCKHyEVckysyorj+zClo9qETVrc/C7Nxoj9nfaduksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749602198; c=relaxed/simple;
	bh=tmc5T8UXk6G7YbbXvCmLiEGvKi4mXkChWkY6w2yUyM8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=io4yutYGDhzXMgGfbF6oHdup1yQZfDJaA2S+yGj498S3eIh0EF0QfJHna1YVm8aGK4yl9YyCdvbpu7OLsKqVssXjfsld6mfWFXa2fv3oAwwPLwlCazRufIIEWh+fdhZnm5Oeq0C0nfl16EFgz1NqDJbCJO+kT8jzu1n78dhOP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=RXgz1jr+; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 55B0BcAu013004
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 01:11:41 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 55B0BcAu013004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1749600701; bh=tmc5T8UXk6G7YbbXvCmLiEGvKi4mXkChWkY6w2yUyM8=;
	h=From:Subject:Date:To:From;
	b=RXgz1jr+F4Nw0vU5ixk0Kjjzmyvbe7BJbNttAp9U/+F5H0weuN+QAT03ASZ7yVKOL
	 ccffK4PNv8re4zPVv+qRWkrhnQS2IVjfmJLrBAxAfOWG1o0uWGONYFlTmuS3x0d3Rq
	 5Cnd3v158xH4dWqqkiQpPEFAJBrPM+5LyMZ7JSesH24wYnG5wQzJ339mZ3WV/BYAyb
	 G3jSzBPXdZZVNiOzYz8cTGeB/xQO9rfvNdK2B1bTmaEOChSUJlmEuHwXo+O6is66Qi
	 EopCaAFLenzszlU9/OVY++v+VzuADJXeQza2APDglG3UuZeiZZFo/gBO9yio10hR4R
	 BHxBSOj+qDZmQ==
From: Luke Howard <lukeh@padl.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: [RFC] net:dsa: mv88e6xxx: RMU-only mode
Message-Id: <1D0097F9-5C25-442C-BDD5-CF8F7D8838E6@padl.com>
Date: Wed, 11 Jun 2025 10:11:27 +1000
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Some Marvell switches have a Remote Management Unit (RMU) which permits =
in-band configuration, essentially tunnelling MDIO requests in Ethernet =
packets.

Andrew Lunn and Mattias Forsblad have previously submitted patches to =
the mv88e6xxx driver to support RMU, with the proviso that MDIO must =
still be present for initial switch configuration and to enable RMU =
itself.

There are some situations where MDIO is unavailable, but RMU can be =
enabled externally (either by an external device connected over MDIO or =
a switch EEPROM). In this case it is useful to support in-band only =
configuration, without MDIO, with the switch being a platform device =
instead of a MDIO child node.

WIP patches can be found here:

https://github.com/PADL/linux/tree/rpi-6.14.y-xebros-rmu

It required changes to both the DSA core (to bring up the conduit device =
first) as well as the Marvell driver. Once Andrew has submitted his RMU =
patches on which these are based, and I have done further testing, I =
plan to submit these patches.

Please note that the tree above includes some unrelated driver commits =
for AVB and DSCP support that I of course would separate out before =
submitting.=

