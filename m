Return-Path: <netdev+bounces-182392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7360AA889F7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321613A5C51
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5232A274641;
	Mon, 14 Apr 2025 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA06op3F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269B72DFA4D;
	Mon, 14 Apr 2025 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652342; cv=none; b=nFqvIQyhXwxuve+FK0GnU3H67Yx9fo/0RwVTUSW4PHur+9v3sT0YCIoE9KMjZ+ZMkwZ1LAv58lNIW10oNUI7MOeGFcATCIWwcg4t2EASTZyh7lJWTg8vOpjHsF4bUx1qBDK8KVd2Pc/ZKSo+oHRteqyi/jMd72Rh/tKG0CJUlE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652342; c=relaxed/simple;
	bh=SFHTdZ3JZB3OkOrPxXWzgW9WoZRWuRNSmuqmd3BwPpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aH5xekEno6qDvHT5QhNrZqyc9Ru0MMhBukCi9GgeWmX0gZ0AKHa+eMWT5mC2+RZ+l+0sy4yLbpxYd6eYvPqiSBrkSoVCPfP6h9X0GZOkAWVnm9tilj3nOczUmMjK3VEzZsefBsZLe+PXG4PpWZvsdV0sAJVhJDGrYDtka700TKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GA06op3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D4BC4CEE2;
	Mon, 14 Apr 2025 17:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744652341;
	bh=SFHTdZ3JZB3OkOrPxXWzgW9WoZRWuRNSmuqmd3BwPpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GA06op3FuwRZz/s3an9qWBgH9VsqKlGZduKmRiyAoO1FL/2ZqtZ38/2yKtSqkA4w7
	 8d/w/PBnf2Z7827GPIV7bEtq/twFsqG0qcyziVCOJVXRCAporukroA6b306pjHR6Dc
	 ynqNap5FFSXO8S9AEQntYbKGeoQzg2wg3MU58SMGjCsDN8as0tVlrAegtdBxWhDV6E
	 pP7hvafsaPomsmKa+I6stLpMXB+SAWw8FE3tjHYB1duClhsMWQq3RBSfhoh/h7Frww
	 NA7JEyq7p1dHPfqIoy+Tih9iKl/HyKJLDfkdjBAeyJCKAruZ/yuJZgdvj3tO7aJvRD
	 QBqImobscLi8Q==
Date: Mon, 14 Apr 2025 10:39:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: syzbot <syzbot+ab6046c8981706660600@syzkaller.appspotmail.com>
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, jdamato@fastly.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in netdev_nl_dev_fill
Message-ID: <20250414103900.04c56a03@kernel.org>
In-Reply-To: <67fc6f85.050a0220.2970f9.039d.GAE@google.com>
References: <67fc6f85.050a0220.2970f9.039d.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Apr 2025 19:14:29 -0700 syzbot wrote:
> syzbot found the following issue on:

#syz dup: possible deadlock in xsk_diag_dump

