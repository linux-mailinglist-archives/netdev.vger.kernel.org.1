Return-Path: <netdev+bounces-116664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 308C794B54D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614A81C21A7C
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598C026AF7;
	Thu,  8 Aug 2024 03:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXEIwUjf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28209770F6;
	Thu,  8 Aug 2024 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723086324; cv=none; b=DUn3SKqOn9Ykc4TA3rJpBSU4wOB4TS8hfeko4KPFwTDt+Gax1gDRZoXgyBtBLlJwokGPvSq01WJK6w472OEJJvUKACWnYTNaZKmns3MC5DSNs9x7dfEyi1LGa3TVcl7TZDGo+EnBPHJpU5Rwx4zMZPS8JBuNxvlaQ0jYUvuhjpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723086324; c=relaxed/simple;
	bh=ikX92fLouxZr+jdI9LogpJin3zNYg+qF/+jOZgiP9ws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnK8dgLGoayc3Pi/Ya5Qb3ONJFF6rCg4uo1nHs487BDNcpP4CsxVMx97onRTSjocOQ8m4UPaBU46JGeoY3SUEkWLAi9kXm7vkdIb1poS/O2xuJvdCuwvt3+TP1M5sfUcjH387zAd7mv1aLdWFEeFnHtcgzw1o/QoCpNCbSYqWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXEIwUjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29230C32781;
	Thu,  8 Aug 2024 03:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723086323;
	bh=ikX92fLouxZr+jdI9LogpJin3zNYg+qF/+jOZgiP9ws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XXEIwUjfz6L5vA18Y/RcKa3hvxgzPm3XlwxKVlXUTGqIOTqeXyBHZM0lLwt+Ks/ib
	 0TY/+devOZqt8majQd/k6EesFasAmMSQORNXJi8h4bIkwwSTOHk1BozhtIJucfasdY
	 SXrfWxwmqbL4s9YIj5lgQbYSNrOZV3L5Aq+4cB8phmn5+05xvpt6KT4mQadkMR7BIo
	 EeDcJa2kYs+9aYZew9HVQpDYygy3i7EfA9koHsha55faAwjUOZG7Rd+Zzn5nQSfHfH
	 3gbHAk0W+0tYojDb8x8YXF27sZYxdVKPz26zJxO903cGbQkeGwN6rj1ZVpB+yJmUlE
	 tsXHBw9TE0wbg==
Date: Wed, 7 Aug 2024 20:05:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] cxgb4: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20240807200522.2caba2dc@kernel.org>
In-Reply-To: <ZrD8vpfiYugd0cPQ@cute>
References: <ZrD8vpfiYugd0cPQ@cute>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Aug 2024 10:24:30 -0600 Gustavo A. R. Silva wrote:
> Subject: [PATCH][next] cxgb4: Avoid -Wflex-array-member-not-at-end warning
> Date: Mon, 5 Aug 2024 10:24:30 -0600

>  .../chelsio/cxgb4/cxgb4_tc_u32_parse.h        |  2 +-
>  include/uapi/linux/pkt_cls.h                  | 23 +++++++++++--------

Took me a minute to realize you're changing uAPI.
Please fix the subject.
-- 
pw-bot: cr

