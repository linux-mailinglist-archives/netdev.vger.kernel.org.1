Return-Path: <netdev+bounces-199297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B503FADFB1E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 04:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2865018969C2
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 02:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCCA21FF57;
	Thu, 19 Jun 2025 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOemKSt3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897444A3C
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750299282; cv=none; b=Hh4q5ddp8q6dOmR70E0WHVd6WM02WfI/8/UAE9lfIHjr1kYISuIDylNPrnPOPbDQ1D/zJK3SVpwPdzCag7f3xyuKolzzfqbbBeeQDGuBVBdXE3M9sgkUsNkAzW0oADo/ANwzRi32icgK5cdUNNCmQvJhO6nt5ixlxSy1KXSkh7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750299282; c=relaxed/simple;
	bh=4faUVFxs2mekwQ5nHq7wQ5v5q6gjPDIwm5ZJuYIXMWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcgrNO3IsBOWHNU57C9Yn0zutmoXSUJei4LylQ94yOJOqwkUCjArkYy1KLN6DQrkbkF9S4fy1rIcqOE721vXbNfqPwkvHmiXMkPniitJ6luCKFPFxc/1/Dm+R+HZPyzGAINer/oCElj2FZTDlRkJ4a63KJZ0LJHNSg1bNM0FIIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOemKSt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED9DC4CEE7;
	Thu, 19 Jun 2025 02:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750299282;
	bh=4faUVFxs2mekwQ5nHq7wQ5v5q6gjPDIwm5ZJuYIXMWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vOemKSt3wTI4YZ6Tc6r2IRBFNYix1u5QOSWgcFfKbxMXp97KtXjvK94n7fy8cIY4V
	 gMkULr3jZ85uxQLC5crxIEQh+YhDbmHQSi9FBzfnHpX36OAOW0dCA97IwtYYjPPa6i
	 yWY85FqC7QvD0YXmpEa0VeZW0ItUiWn5LaWwi/stI2KBfgWe7s+LlAEQYIStD+Z0Ii
	 KOLEa5u7djlpR7JNwSQga9zpte09INAdduz8eRz90UtLwnHXDOAzP/TYFsaK8IKVvd
	 STvS5bkHE/jh5kzTgcST9DGAchKU5XUpEOQopkNyFmPKqNxOye/G9bYREETuTzHX8G
	 kYdlSxVxHZQNw==
Date: Wed, 18 Jun 2025 19:14:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v4 net-next 1/8] virtio: introduce extended features
Message-ID: <20250618191440.0361c343@kernel.org>
In-Reply-To: <2d17ac04283e0751c6a8e8dbda509dcc1237490f.1750176076.git.pabeni@redhat.com>
References: <cover.1750176076.git.pabeni@redhat.com>
	<2d17ac04283e0751c6a8e8dbda509dcc1237490f.1750176076.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 18:12:08 +0200 Paolo Abeni wrote:
> -	u64 features;
> +	VIRTIO_DECLARE_FEATURES(features);

FWIW this makes kdoc upset. There is a list of regexps in
scripts/kernel-doc.pl which make it understand the declaration macros.
I think VIRTIO_DECLARE_FEATURES() needs to be added to that list.

