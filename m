Return-Path: <netdev+bounces-69172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41441849F37
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 17:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D70283E2B
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 16:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C44E32C9C;
	Mon,  5 Feb 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="da9ynOBr"
X-Original-To: netdev+bounces-69171-xuanzhuo=linux.alibaba.com@vger.kernel.org
Received: from out0-178.static.mail.aliyun.com (out0-178.static.mail.aliyun.com [59.82.0.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A1A3FE44
	for <netdev+bounces-69171-xuanzhuo=linux.alibaba.com@vger.kernel.org>; Mon,  5 Feb 2024 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.82.0.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148976; cv=none; b=ioxm19VjbMuivaznxAXgRNRedRtclXiDVJIXsxJZNn8uwFTyAR3l6XEbgGxMDGVvwvuTU8kM3Z+gX4cHy0pQABVphbDuFApvluqkRM2bQJwdY9wnJrBwho92Jt/d15bFwJL+zZYObaq8QNbJIu1nROYXkUiLkTA7ao9lktrcdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148976; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=KzcFeI29NF0N6H/oApDKEHj4lP5KxGa0uFSFbAPMuJaswUR6xvNbvVq3dy9lJUAXI/d9udYxNJuZMTDiCcqaqXJa089tQmeh2PuGPYhQ2W4lINo80JFbtRVVV9P3w1GJMDRBTs6clcW5hJbETG7E0FIf1/mAdveage/h5Mz379s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=da9ynOBr; arc=none smtp.client-ip=59.82.0.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707148970; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=da9ynOBr0p4Szwok2/nFlACXKAduJ8pSIAUUIpQq4V64UQdAtOvtNDa62wUpXR9FDLZNIbNvmI6793bSkKiCqckOHwUw+d+W7GNcBernnXNT9dBNIpg6WB8U13t6LhN44w9EpPnvYFkWoM2OAAuUpq9/YdRuMq1iZGJyG1VcwF4=
auto-submitted:auto-replied
date:Tue, 06 Feb 2024 00:02:50 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6W1BBVENIXSBuZXQ6IENoYW5nZSBkZWZhdWx0IGRlbGF5IG9uIElQIGF1dG9jb25maWcgdG8gMG1z?=
to:netdev@vger.kernel.org
message-id: a63e3aa2-cd47-426b-8c25-9cbece401841
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

