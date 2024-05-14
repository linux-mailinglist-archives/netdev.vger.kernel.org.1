Return-Path: <netdev+bounces-96364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B518C5752
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 15:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D111C21199
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761FD144312;
	Tue, 14 May 2024 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ddo4i6EO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9501411DC
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715694324; cv=none; b=Ml27B1Cp0mO2cR5zLJrPGi9pxbL6w4NTQz6pYdbvfGIoujl4HFS+GOlZ8u1EB7QrxSdiwhLxN4CYV+6UeaiUFwREz2meOIQ9Pdf1Y0xBkydMF3ktquj9x5rqF8hRaPRbgsD+fLNDIhgqcoXn8kvpAxp3kzzJL6DPgQs1m5/WgrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715694324; c=relaxed/simple;
	bh=hazaavQ9oXyOqOj2+giBjdK0Qhv7QHN4tr4k538q6LU=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=hvDx5hqluQwHLm7v9O5MMplXoRCQn0C8e64aldruGngrFaOGJT/GnSr/KO8dtvyOH/AtgHu8uIE/tpurmseIi4wdU3lfWoYR6030YNykJmB5f09rn5w04ktLTNZkRr2JM2EqKlNMClg+iVYAyqYb/Oui1xjAc0ZtvBml8Z3CpJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Ddo4i6EO; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1715694318; x=1715953518;
	bh=hazaavQ9oXyOqOj2+giBjdK0Qhv7QHN4tr4k538q6LU=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ddo4i6EOUCtxfKkm1kNlr0hb5X6XlEv3HUzqTzPGLSdjhKUnjFHFCAIVUP633owgB
	 buaXAjVUjzrE+EkceInyUQkQ9xdbnHL7KUFH0qfQNPPz8SCh01dWtFCYzUH1bjZ4nY
	 XvtRx6wwFNCcWT6XcnyojaJTpNg9q1qb8sLsIOD7h5Nwx3cEE75VBLfqvAga8rwOI5
	 9lhpHn65rgvHfZeX8Psb6rAhYDqRAq67Z916vCb15y5rqCq23glJc64EHTbhJvl2MF
	 b9I79MxyH6O3n4wnLBO9HKXlDAsGHJQiWcJEe1qq1FdIy+EikWYg8UWwLQhnFTyhRp
	 2xvEQg5lEXieg==
Date: Tue, 14 May 2024 13:45:15 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: William <wtrelawny@proton.me>
Subject: How to submit pull request to ip(8) manpage
Message-ID: <lcAJXzyuvgWzFPAZ0cW9Y2z21zgYiYVSLXj4i9u-i6dXP47oMmbDDrMlVfT47GltBXynLRXZk-3rMZ4eS37WCgPIQrEF1J4NwqnvgEfZ-ik=@proton.me>
Feedback-ID: 46067363:user:proton
X-Pm-Message-ID: 6349d2c918f74d83ef9f054e303709a7def2f18c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello, I would like to submit a pull request for clarifications on the manp=
age for the=C2=A0`ip` command, but I cannot find a way to do this. Can you =
please direct me to the git repo containing the manpage so I can fork it?

Thank you,

- William

