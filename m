Return-Path: <netdev+bounces-180823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EF5A829B2
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCDB9A7F7A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D78826770E;
	Wed,  9 Apr 2025 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1WOLsQz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD3F25DD0F
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210892; cv=none; b=UGDV2QERMKMQw0ag1mr0uo11lGSKULL6KnXvhaezPjrKBQ2zru2z+/ZH3Uogi1yRWMykcAXhSU3zclLn8C7b3eLzSI0vxERoTPBI+qzGx4kpCr5otJUOndjC2c7uu03GjDl6Gt8sYi6AskMNXBGOoWQ7MKiqOg/kI1IuXtGRRBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210892; c=relaxed/simple;
	bh=lsh82A2Go/c9EMRpnCp1AUWKAkZRWIGkptPANNDv1As=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNOzjcHJB/oChuTAasVNEg5ZNBpJKliOjkk/cDq0HIn+vw9pmY9atwGYNgJA+lS4Vac9pD6fkjkNzHAVIkgzW0+Z5tPeytzhzpAxPsSaLhSkp0OMulWjnFvt6zvYbSlfgrbYJVcmMi4PGe0uvCOayV/MqcFAqq5v0cs12oZSxsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1WOLsQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017DFC4CEE2;
	Wed,  9 Apr 2025 15:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744210891;
	bh=lsh82A2Go/c9EMRpnCp1AUWKAkZRWIGkptPANNDv1As=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q1WOLsQzdb+M9rIohM9rZl7rqG3TjKVnn/7DuxrhpgWAPpQLFV3HL4Zt1t9rZTtmu
	 +qnXebw3Wa/yNnD1jg80SQgXLCtSWqkQx6hrKZog5Ehg1rn8uhMxIOyeVKxjfnPIy/
	 Dr/ipdGixf2hhP5xB+3/76jiKJFSr8mfhpdR8Koqsa/d+FDinjAgifpsIr8oVuGiG8
	 46ea1vOH5afqk4fGJ7rcwy5gDvLdW6dJ7+g6Mam9J68/hxzDbexNj4+QwuY8AqBGS+
	 5SmCukbLZWMpESpJeYAvVOr6N+4BiU3gwuVFuNZ8Qy17iG3sgBc5Wv0/ZQpO+W60Vw
	 4E/Xg9ctDdDbg==
Date: Wed, 9 Apr 2025 08:01:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <donald.hunter@gmail.com>, <yuyanghuang@google.com>, <sdf@fomichev.me>,
 <gnault@redhat.com>, <nicolas.dichtel@6wind.com>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next 12/13] tools: ynl: generate code for rt-addr
 and add a sample
Message-ID: <20250409080130.43c99841@kernel.org>
In-Reply-To: <4fdcd9d0-b150-41c9-8d50-655e1f38098c@intel.com>
References: <20250409000400.492371-1-kuba@kernel.org>
	<20250409000400.492371-13-kuba@kernel.org>
	<4fdcd9d0-b150-41c9-8d50-655e1f38098c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Apr 2025 22:04:46 -0700 Jacob Keller wrote:
> Nice! This makes it a lot simpler to write small tools for dedicated
> tasks or debugging vs trying to use one of the other existing libraries.
> I think it helps make netlink more accessible, and appreciate the work
> to support the classic netlink families, even with their quirks.

I hope so! I must say, I'm a bit surprised that we don't see people
writing code gens for other languages. It is quite fun.

