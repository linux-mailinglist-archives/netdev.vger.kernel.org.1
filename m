Return-Path: <netdev+bounces-215656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2C2B2FCBC
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1866B6334F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B42625F797;
	Thu, 21 Aug 2025 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qS8BEa+Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F602EC573
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786514; cv=none; b=mPOBhhCXkbH4NfCgXYbaTCgcAu2Mj41TltsDVzz0/yA2d5+SHYcOgGgtjdDbRo53LCX0WsNluMNTOk11rfgJZmGVYD4mnhm4rwZHLx1gpmv/dMbVI6y6bgh6G6fk04eLF6CTtuyHRuI4pkdbrFwKv5QoMSMPnbefh7AGAqQ9ilI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786514; c=relaxed/simple;
	bh=tmFNfhTyU/Dd2MoiV3fKIrB2aFtvsr4jFxh/6PDDV1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRkJBVuBZqztFnKNrjqqs5RDWhA8wJqnZYFOvtW2LGdTFlpwPyueDXoRP6EGt2VTrpwCnEyG2yZL9sFTG1mVBleLTA4sm8jaEBDpFukgxMccuDvpJQoUZFlTtsnYdbNrjJBUsAXSi0P/6wm9CTVT8JnJ1DHkcvnVc1l1lJ2V2Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qS8BEa+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF32C4CEEB;
	Thu, 21 Aug 2025 14:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786514;
	bh=tmFNfhTyU/Dd2MoiV3fKIrB2aFtvsr4jFxh/6PDDV1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qS8BEa+Qaj2cvRyCJaecoEVGJzhvmYUfEbOmC9rby0u+/wFIIAnsn8xqb2y73r90U
	 P8wjyUNqIeMgrs3yj0MajEl4ssGOABm2pl8uDQBx5nYYHO16Hzt92Ab4fHwEzrQyuF
	 r8iZ/a+ajMZDUnuEPfJGSfF30HeKu5ODHAidAoDA/OziedZ6lFWK4ikh2z58cMuVA+
	 Ah6THTbDV+zcIXoUGcirCHR2YEv+tSJLa6gkPsxZ7MyGgWZn5O5Yjw1ZEHj89/iJDU
	 NAZ56j3ORb05VFiosmHZjX/rvOzBKZ+yFE9yncc3fNh/pmNw8U+DNHxlIIAhZpxpF/
	 qMtlEcD5UtC0g==
Date: Thu, 21 Aug 2025 07:28:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Taehee Yoo <ap420073@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, almasrymina@google.com, michael.chan@broadcom.com,
 tariqt@nvidia.com, dtatulea@nvidia.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, alexanderduyck@fb.com, sdf@fomichev.me,
 davem@davemloft.net
Subject: Re: [PATCH net-next 00/15] eth: fbnic: support queue API and
 zero-copy Rx
Message-ID: <20250821072832.0758c118@kernel.org>
In-Reply-To: <5bba5969-36f4-4a0a-8c03-aea16e2a40de@redhat.com>
References: <20250820025704.166248-1-kuba@kernel.org>
	<5bba5969-36f4-4a0a-8c03-aea16e2a40de@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 09:51:55 +0200 Paolo Abeni wrote:
> Blindly noting 

I haven't looked closely either :) but my gut feeling is that this 
is because the devmem test doesn't clean up after itself. It used to
bail out sooner, with this series is goes further in messing up the
config, and then all tests that run after have a misconfigured NIC..

Taehee, are you planning to work on addressing that? I'm happy to fix
it up myself, if you aren't already half way done with the changes
yourself, or planning to do it soon..

