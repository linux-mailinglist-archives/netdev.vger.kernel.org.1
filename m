Return-Path: <netdev+bounces-139717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2439B3E67
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6CF1C2104C
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34971F428D;
	Mon, 28 Oct 2024 23:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7JY9HXD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62E318FC83;
	Mon, 28 Oct 2024 23:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158065; cv=none; b=JQua+xHuLKQhRszAc2WRcLnETJ5YNSbHLZ7kLxJxF2UWRRE+EzPvXnV8S30b4wxkMs6PaQYZjaJIHOAuy6nBqmlXDmyLf+EhS7SYgQOapuGhRCS/8lYrMQSXJFZZrtMn4yvlI9pFFpDfz8zpGChsl/6xdexZUhmsF2fGQHkAE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158065; c=relaxed/simple;
	bh=iogHFvfb9MqEi1euQ4gV1TYc3cLwkdDGJc/GwTd5TpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfeEASZz4N9eIweCR1e9/tYp7di5Ryibaxhj5v3ONIaCEh0gWzNnQShX/qf3U0swBeK5Z7+fs93D2mID2RXOPnE5bhIul80fftGQ/oGH1ldWl7leNCiXxaQInzrscJux0jl9dJQ1MRskyPOmAwYn/KaSEzva10mfUvg+XZvemGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7JY9HXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BB8C4CEC3;
	Mon, 28 Oct 2024 23:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158065;
	bh=iogHFvfb9MqEi1euQ4gV1TYc3cLwkdDGJc/GwTd5TpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p7JY9HXDjrVB4MavRa19lkHzRIc+peGI56/PNPnc3PCFKrJLWdUbVRS9dfvXEVpzl
	 joN+kxKXiOYdFkw3mUJpVLXi6vUx2Y5GpyCFHCVuqdJIHw/usTE0nbnturB+RjovJ0
	 zdHq5vQeA6r9ksZpg2Nqv/M+00jvgojiAYH19s85dmNSeyJeQ2e8ZHuxU8iAzXvADz
	 VdrzzNOOeHMuLjGq/Us4XbiIswR85oyA+ucpnbcPxNJxasZVxhUJ+FN5gK/9DnAzyf
	 wdlgo+jCl4ngWGZhIxl2IkafgsERQjpRpQlBDTu9jYWYts2yFST+NoOELkClrcPEoL
	 5VBKw3uJcRjWg==
Date: Mon, 28 Oct 2024 16:27:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexander Duyck
 <alexander.duyck@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 10/10] mm: page_frag: add an entry in MAINTAINERS
 for page_frag
Message-ID: <20241028162743.75bfd8a1@kernel.org>
In-Reply-To: <20241028115850.3409893-11-linyunsheng@huawei.com>
References: <20241028115850.3409893-1-linyunsheng@huawei.com>
	<20241028115850.3409893-11-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 19:58:50 +0800 Yunsheng Lin wrote:
> +M:	Yunsheng Lin <linyunsheng@huawei.com>

Why is this line still here? You asked for a second opinion
and you got one from Paolo.

