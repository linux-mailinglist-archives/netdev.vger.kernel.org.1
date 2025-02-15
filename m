Return-Path: <netdev+bounces-166722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6127A370E3
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 22:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9505F188D363
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 21:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD4F1FC0E2;
	Sat, 15 Feb 2025 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="doNYpEiP"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C11170A1B;
	Sat, 15 Feb 2025 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739655000; cv=pass; b=f6TlV2UdLUK3bTqMywZ7rZhBSje5MJfmw+jl1Z+BEc3bvu0ZuIKZlcya1y3GmZWEewas637p6bXc1ucT07I8KSn/tDDTbxuXwlwr7yZQJE2daL98jncZAg6vdR/AbyC344nHOlrOJOKpEl9RxxGNXbr863s0x+hG0ydoywPyP3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739655000; c=relaxed/simple;
	bh=YbGjdxDqEN3wLUVnxAfJo1FEzrUh5aC8korUEZOe9yw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Tc2+FrG9YjrJXhv3g2PAjymgjngUE/WcZwxHIc6m/bdxOb/5HYGvV5GySeHHWIFuu4ZIKcX19zx/YEwp8Gn6qzFfYfV2l9kf/lTBs3aGJr2BMPQQIlCCdNJBgb5sguBWesybmrJUCZTKIRe7MQlAppTzHGQQyjHTzhrpzP+SQCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=doNYpEiP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739654932; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hP+gMUCdS8lR+jzrhe1Yi8O77W8UGO6ljEDJXr1oaydEENkOVVD2/Qf+n1ejFU5mu3gv6h6LKypcY4ixf1lQ0ynXarsacl25432L1xxmTMbXqDsm/ESTRq5ZbnqZcEtWAENAY98moyqc+d+un0wpA0DcxCsb9i6k4prmjfn2RfI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739654932; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YbGjdxDqEN3wLUVnxAfJo1FEzrUh5aC8korUEZOe9yw=; 
	b=iYL5qTQr3ekec/62sKIVDGjo6kHPEShf3AhjHT39vqkerv+40v7HVSAhFcwK5C0FB4nsLi80c3QqQve1eWbOFWoihKg36eD/kKI5mplHTPsVopLJB1ZtXw5pbvwsETNnMOcVaS/u/wwyD0c05afF5kW76VWrtmuUAJHSaQWhmvQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739654932;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=YbGjdxDqEN3wLUVnxAfJo1FEzrUh5aC8korUEZOe9yw=;
	b=doNYpEiPa0y/lz22hqgCIvgAK/lf+tAl0lnK0/XzrrXzuWGKDbBGp1sPlDE9lD/d
	AbIe/FfqEam25Zo+SSUdhVbvyZRkqJExA9jZ0EsSmo8osItS2JuhvnLW27YZDtpCeCd
	bcg99qdC82jzfJFGPsEVFNtOgq+mvtCMCPcwlTAI=
Received: by mx.zohomail.com with SMTPS id 1739654930320229.91104007025683;
	Sat, 15 Feb 2025 13:28:50 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v10 0/8] rust: Add IO polling
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250207132623.168854-1-fujita.tomonori@gmail.com>
Date: Sat, 15 Feb 2025 18:28:30 -0300
Cc: linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org,
 andrew@lunn.ch,
 hkallweit1@gmail.com,
 tmgross@umich.edu,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 benno.lossin@proton.me,
 a.hindborg@samsung.com,
 aliceryhl@google.com,
 anna-maria@linutronix.de,
 frederic@kernel.org,
 tglx@linutronix.de,
 arnd@arndb.de,
 jstultz@google.com,
 sboyd@kernel.org,
 mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tgunders@redhat.com,
 me@kloenk.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <8BD5E78C-0B91-4BD0-A38E-7A3681536DB4@collabora.com>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External

Hi Fujita,

> On 7 Feb 2025, at 10:26, FUJITA Tomonori <fujita.tomonori@gmail.com> =
wrote:
>=20
> Add a helper function to poll periodically until a condition is met or
> a timeout is reached. By using the function, the 8th patch fixes
> QT2025 PHY driver to sleep until the hardware becomes ready.

I tested this on a driver I=E2=80=99ve been working on. This is working =
as intended.

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>=

