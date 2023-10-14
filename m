Return-Path: <netdev+bounces-40912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E202B7C91BA
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0D1B20ACE
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FED366;
	Sat, 14 Oct 2023 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lx+uf/l9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE2B7E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163FCC433C7;
	Sat, 14 Oct 2023 00:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697242492;
	bh=IUwDc+lIbs+tTFWl8nq5IDKM2QYm+ksyEv0F8kZhp3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lx+uf/l9SI6HIFcz+uW+QZJ4k70XyX9z9hPgBKjc4fvooJOq52KCYpBAul8q4BoQU
	 BIs3UeAqoHcMsvoqhtNMXelMTDmxVrwE76C1IZm1mhFN9BZhWW6/UD5p4CPkVoc8EJ
	 zCMeHroyrrR9jk5h3SklLiCMgKgjf4O0cB5O6IzdFRnsVQ7WofLhwJzQ3IQmdj8qBj
	 JjA0D2k4GsBF+aqrnZn1XZhp/1VLcNpnSU4v2XgAugOaXfzPi0XAUyw4DBtsDT6GmP
	 74gWs0M9acXih72fg5NrZDWPU+LfpPJgruQFbQ6NyXGm9fDknNZ6LyuUYSVOU1KyTu
	 KuIBUp/1f5L/g==
Date: Fri, 13 Oct 2023 17:14:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chenguohua@jari.cn
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] etherdevice: Clean up errors in etherdevice.h
Message-ID: <20231013171451.48a2d11a@kernel.org>
In-Reply-To: <22a751c6.93b.18b26b780d4.Coremail.chenguohua@jari.cn>
References: <22a751c6.93b.18b26b780d4.Coremail.chenguohua@jari.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 09:47:22 +0800 (GMT+08:00) chenguohua@jari.cn wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: that open brace { should be on the previous line

Please do not send any checkpatch fixes to networking.
-- 
pw-bot: reject

