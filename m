Return-Path: <netdev+bounces-70297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D3084E495
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C6B1F28A36
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDD87E565;
	Thu,  8 Feb 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xH+UrNBn"
X-Original-To: netdev+bounces-70270-xuanzhuo=linux.alibaba.com@vger.kernel.org
Received: from out0-198.static.mail.aliyun.com (out0-198.static.mail.aliyun.com [59.82.0.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07397E78D
	for <netdev+bounces-70270-xuanzhuo=linux.alibaba.com@vger.kernel.org>; Thu,  8 Feb 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.82.0.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408022; cv=none; b=RiV9XcpyG3Ex+5EUimN5asdRTaKUhDjEg9BIBT7kf0JQT6igpVE2os5ULktUrjFgqTaeK3sb47UogoUEXKH3QNKkG9XaUjA6ep55Q7ZE2ESo9xjzoAN3u8gA1qDIO63jQgSIaFo5Zicn4gCL13GnUZxzxcS/ERzBrmHz89eCxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408022; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=UxBgXRquPJzsuIdqnPtxGPSCcLWK3xN5BT5fusHpf+u/8ZmsiKHjyYGCSRukGHFan6H8X5OYPd3Lxke9TTNe/vGMYYDcCp2rtBMMLdPmKKIPSEkmy+AnXuq73B1cpUA1Sld7+hnH//iQ48ErCVuJU8hwFkwJipKwRX+9gEbDboM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xH+UrNBn; arc=none smtp.client-ip=59.82.0.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707408012; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=xH+UrNBnXTxupkWe3HT2RbQokplAw7bZUKVOrEZexzLD5agt5BCV4U5YA9q+5QQWacJu673QJA6zbP+ILqfyvS0j+/g02L+nymoTxZT/EE1zim4oLEcIhCkbY/sc+yxLqhS93ryozmatwbiA4cQTmKpHIh20WRO7klYRF4Pd174=
auto-submitted:auto-replied
date:Fri, 09 Feb 2024 00:00:12 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6W1BBVENIIG5ldCAzLzNdIG5ldC1kZXZpY2U6IG1vdmUgbHN0YXRzIGluIG5ldF9kZXZpY2VfcmVhZF90eHJ4?=
to:netdev@vger.kernel.org
message-id: ed71a28e-fa08-4f1e-bfaa-cf6019136417
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

