Return-Path: <netdev+bounces-69553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CF484BA76
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FB31F27344
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DED134727;
	Tue,  6 Feb 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fwRtqaR0"
X-Original-To: netdev+bounces-69552-xuanzhuo=linux.alibaba.com@vger.kernel.org
Received: from out0-178.static.mail.aliyun.com (out0-178.static.mail.aliyun.com [59.82.0.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE0013341F
	for <netdev+bounces-69552-xuanzhuo=linux.alibaba.com@vger.kernel.org>; Tue,  6 Feb 2024 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.82.0.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235212; cv=none; b=MRIMWltiEYMNoFBORoEXSFslwK8JO/uX5xzvkYHEx1wU4a0OIVWFlUe947evmyKwmYjNeJEniqsmsvWtPHXBgKOcfwkUEcpmQQCGBa9hSEFywSImDdeiZutgj8mU8Dx4Xm+GnXMCx9iJB5/R8XHzXNHMkzi8xtM5lYfmSBvCdAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235212; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=EfaCpLA3cTrgE9YimBKKADLetFTFUDUGj3UmEAViflonWLNt3zB9YG6l87rA/+PnsznAYQBxDZyltCOm1wSX6gi7e+D60JF/EhXyqxSduYUtnKzEqt9c1/SHpnkWW6V6vucC4jSD9qBwRlUJ6ptzZGXBTDp0GqDwkwUiebqWHfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fwRtqaR0; arc=none smtp.client-ip=59.82.0.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707235202; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=fwRtqaR0GVjaUIkM22Yj3TV2kgIc3P5zwzgz4AZWpCfEe8Kbx0V/99nbHTQkMBsu5hXvOSRtj+/EhCos8AuiIPtD+CpzKg5JznsJ+SaJZB2NA+UDajOg3coUv6GOiOfohI1hzfaGucElzRry2j2HhrB6H8Hfc9vPQ0AS3dZUUvY=
auto-submitted:auto-replied
date:Wed, 07 Feb 2024 00:00:01 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6UmU6IFtQQVRDSCBuZXQtbmV4dF0gc2VsZnRlc3RzOiB0Yy10ZXN0aW5nOiBhZGQgbWlycmVkIHRvIGJsb2NrIHRkYyB0ZXN0cw==?=
to:netdev@vger.kernel.org
message-id: 238c7090-adcf-496b-8cd3-d52ed5af8f53
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version:1.0
Content-Type:text/plain;
	charset="utf-8"

Hi, I'm on vacation. I'll get back to you when I'm done with this vacation.
I'll be back on 2.18.

Thanks.

