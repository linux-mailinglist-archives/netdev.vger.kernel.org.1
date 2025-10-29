Return-Path: <netdev+bounces-233744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EACF7C17EFA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648F61AA7DE3
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E56D2DC331;
	Wed, 29 Oct 2025 01:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxyVKnwR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309071FDE01;
	Wed, 29 Oct 2025 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701809; cv=none; b=cr/GqjYNnR8YlYQF1O12iSPTfSvgVA+FVDy7Y3RTamvy2NXL6CgBuPE0zkqPmXg2C94gmRbDjIs0fAkof1zjz02SpspCdwzrqHITmJ+e695Ci1I9NJHEUbY46SuHmq6lJZ74JCfXyPdjkUOxlnNES2VQfzQf6wl1sWKM9YGFN9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701809; c=relaxed/simple;
	bh=ux2eSaQ7XiHLi4C5ZP54ZyVERw3FGYnN2Zk7GIA4my8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJldFGr+NT5RYBwaQMEaCzSVk3xp491ySU1/nkxbXQgTPsI962yo094D3pDos/0DjZG0WVpubxTHnPAWNgb/BUdeygpqRBmwKiWcsDrlpQMUGnxSYrz8QtdPZZvxksw5LWCD6Ea3duuyz6158uGAX2/glJrkV5h0TWL4Ok7SsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxyVKnwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3712C4CEE7;
	Wed, 29 Oct 2025 01:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701808;
	bh=ux2eSaQ7XiHLi4C5ZP54ZyVERw3FGYnN2Zk7GIA4my8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sxyVKnwRR9wwGS9x2vMA1h5UU5A6bIU/FJL2wCTlz6z6ChqZTaol/oXcJPI9YMR1m
	 HJsdKbVdyZ80sKHUq2/YQUTl1QiOMm/LoKh3clKKVsbya7whzPONKjDutO1Qf9AXSA
	 4tu57WWjkQ8RIUgDGohmjg9UqKJjkQx75y3nyY4UXe86N0aZgyO/VLQEre5ov7a03P
	 3SPn7N3im/31CzKbkWA7UjRDwukF08S3O9KbI98bfwyYoaspsr/jLt85bvrOmt0Tc+
	 k2/5YYcdEESTM1wb0qT8hEAkzCKzjcG4+1UJTBIJGD2c1yPkKy5S1iYLTcsWQomWHY
	 Z8SvdPj10pUFA==
Date: Tue, 28 Oct 2025 18:36:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] dpll: Add support for phase adjustment
 granularity
Message-ID: <20251028183647.1e9dc130@kernel.org>
In-Reply-To: <20251024144927.587097-1-ivecera@redhat.com>
References: <20251024144927.587097-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 16:49:25 +0200 Ivan Vecera wrote:
> Phase-adjust values are currently limited only by a min-max range. Some
> hardware requires, for certain pin types, that values be multiples of
> a specific granularity, as in the zl3073x driver.

DPLL maintainers, please review 


