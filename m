Return-Path: <netdev+bounces-105860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0EA9134B8
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 17:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A17A1C20FD1
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECC016F0E7;
	Sat, 22 Jun 2024 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pGW0Kp8Q"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618EB43156;
	Sat, 22 Jun 2024 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719069359; cv=none; b=C8APLuhQXE1EXOZWy+pYw4GhrnmUP7w7CIg7bfYJl9wookZUHTq9tCNhuGJTtOMdElObCmw9qa0wY2vMvKvUcLh0IEd540RlBG0iSdhjjgIehI3VomvH7cAd+HN31c0Bp6a9NTFLUBdC99iO8swdh1L9HLCuobaA2oSNq6q/xNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719069359; c=relaxed/simple;
	bh=fKO6cKhLDetMCWuOqjJT5MrxvFKMPuKR9jg4oHo9kQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQ5H2WkZY98+Ihj/+7Va1SORsMAs8f4IXU7iIbG9i0jqAgUOYZnr+NPJaYD37/L5na0vbnnJSIK8zPzVehX1S304/Tlvc67PCv9T6FNDQFRh3qYRl64/U+yO1kcJfO2WENUJnNnMS0J+RbED98Do0GAmBxN7weX0emjzdh55Ngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pGW0Kp8Q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=u/8MZvNVjE3HGccbfJVlLB0/ThMviFL2sbZ039sccRc=; b=pGW0Kp8QKF70FDXhq6o6d/UdIZ
	ny3FJn78zlj0lviZOCPglkjj+nDeWzsJbnpLIKgweD4ecV0khNo2oSc3KuSw/Pqo8OShSIbIGZYcd
	n1pZ5MCIHm9dDzP2uqg0kegjBG68PKQkPlhZnZoDYtkQSLIzd88nVYhXcZHdhctnZ0OvKjFUkj2oI
	DWy5HdHcwcAQeQgxg0/eMQgJWnAz+Do9Z+ptN4iP6QIKjjMdONEMyguCMFL2+RNPZi1JogNBdyNW4
	J6JnW3LbIaO/UvMRTWawu+H1iusbi9Fsq4BLxeKLT1E0DbqnTNqAGazJKUlmmcOBT+WwNc/LgWfS0
	SZ4LN4Cg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sL2Sz-0000000CJTH-3kI8;
	Sat, 22 Jun 2024 15:15:49 +0000
Message-ID: <ef3688fd-d1a5-4045-baa3-1d51c24045c9@infradead.org>
Date: Sat, 22 Jun 2024 08:15:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Documentation: best practices for using Link
 trailers
To: Kees Cook <kees@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ksummit@lists.linux.dev
References: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
 <20240619-docs-patch-msgid-link-v2-2-72dd272bfe37@linuxfoundation.org>
 <87v821d2kp.fsf@mail.lhotse>
 <0BD32B85-22CF-45DF-A70E-FFE8E24469A4@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <0BD32B85-22CF-45DF-A70E-FFE8E24469A4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/22/24 7:40 AM, Kees Cook wrote:
>> I see some existing usage of the above style, but equally there's lots
>> of examples of footnote-style links without the Link: tag, eg:
> I moved from that to using Link: because checkpatch would complain about my long (URL) lines unless it had a Link tag :P

We know that checkpatch isn't perfect. It's safe to ignore such complaints.

-- 
~Randy

