Return-Path: <netdev+bounces-69885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DDD84CE81
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5141F27EA5
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2EB8005C;
	Wed,  7 Feb 2024 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mmGoRHH1"
X-Original-To: netdev+bounces-69884-xuanzhuo=linux.alibaba.com@vger.kernel.org
Received: from out199-20.us.a.mail.aliyun.com (out199-20.us.a.mail.aliyun.com [47.90.199.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96C680050
	for <netdev+bounces-69884-xuanzhuo=linux.alibaba.com@vger.kernel.org>; Wed,  7 Feb 2024 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321664; cv=none; b=h1NlpJ6AQsf34DbxG4riKc6k9VvAJ100BmahdxXiuhJ8y6x2LlPwb1d2RSYhS5BuK43V4VawU4PPbFpImXmgCe2YGpweZvCxOiRpCrqHjeIwNcSF8X0Ob1YpcHb+bP1qF+D9SFS6ZW+kU/PwkWBbx0qqXgjRsxCCxFXJGiP1ONU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321664; c=relaxed/simple;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	h=date:from:subject:to:message-id:MIME-Version:Content-Type; b=gvB/afxkr5ZTfMfL9Pn3KPcFuXceRrg0A2srlGR2VzQUdf6zbsbCOHDCwk9NlNJ60lSA3rpXjYsOV6DiBVznB06TuOjkrRYGhJxLsPEBTnWow3m7pp58a71N15IQEaJqedzQ/tRJ5zvyRW91W0sw3OI5D4a6qN2G0w37hcchHsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mmGoRHH1; arc=none smtp.client-ip=47.90.199.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707321644; h=date:from:subject:to:message-id:MIME-Version:Content-Type;
	bh=a+BuHGTS9P2uQPIBTFfFeLBBud0i07Omu7OakIuFqGU=;
	b=mmGoRHH1HvDNyIe1FYaKkkVBjKXgQUPgrQ63fUgrl+QBWB5VaWMin09oxKUQvNDUkpqSlPgqSHyPFb4YHc7lZNjyihd3JpS7R8pgOayVO9kQdSGLYjW2wbc4lipAw/kpN7hM6xLjledpp34a+aV8ldrpRtw5KRoTFk4ZIcGkMwk=
auto-submitted:auto-replied
date:Thu, 08 Feb 2024 00:00:44 +0800
from: <xuanzhuo@linux.alibaba.com>
subject:=?UTF-8?B?UmU6UmU6IFtQQVRDSCBuZXQtbmV4dCB2NCAzLzVdIG5ldC9pcHY2OiBSZW1vdmUgZXhwaXJlZCByb3V0ZXMgd2l0aCBhIHNlcGFyYXRlZCBsaXN0IG9mIHJvdXRlcy4=?=
to:netdev@vger.kernel.org
message-id: d599805f-ab6a-4178-aeed-5bdc2e8906ef
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

