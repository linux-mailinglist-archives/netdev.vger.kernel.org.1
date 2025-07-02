Return-Path: <netdev+bounces-203399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE27AF5C4D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A036F3BAB2A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7CB2D3731;
	Wed,  2 Jul 2025 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fR6NjkkA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77152D372B;
	Wed,  2 Jul 2025 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468853; cv=none; b=bCapz6cTytotWpwEihCoOGKDX3+TCaXt6RpgbkCEC7N/JGkHc9114/JViIUeTtVi9ez4tGpwS1dNEWqAZvbAky3MR3PTJcWoKCnUWrxTINTI/9FGHjVx3Z5aqA/LrlEgVRjCk07JBGGErGzHn97qqosHqsMxh9Wz4pfZrtqGetk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468853; c=relaxed/simple;
	bh=ZVVmzRk+1uOfLjydmfiRI2snJfafTc16nhWtrTKfZgU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGzwIBXcs9UqJsJC4DnbT0WJ6vew9B85y0aRFXjjJx7PYxKq/IxsTlXP+u5rmNELYWQ6Jyzc3Xwdo7+uNtaTOyG1RzZ9ir7LVpKiOqt+b2u8GcqZYVW93KsCvsoCpYBEPECU8J9nOJXR+M8ThAuuKzeyE/7MDthAxQumqVuq4Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fR6NjkkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E42C4CEE7;
	Wed,  2 Jul 2025 15:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751468853;
	bh=ZVVmzRk+1uOfLjydmfiRI2snJfafTc16nhWtrTKfZgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fR6NjkkAjXfB0N+UnXSI80T5LjwCE96dO7k64gM3+szFP+lkPU/CSPOuVIcTwKqh8
	 B6VZ31fRovRkgqE+OwCh6avShasGTqpq5a+NJC9XZFmhJe3OhaueF+QBfuf8ig+IZJ
	 5s4cAw0JLdIfhTgZifyIsiok5l/zO0KvkWipJc0QevJXl/YA9HishA6pAT6lLWhQXl
	 S0b3Vc6sXeY64yTLneQrAFI7kdmf3+F9AKgAX9lN46KqbAf1FeLamS3HanUKZxL/Ir
	 VvZoKqmmIkju3t9+5hHmU5OZI27j6wCJaFzoOyQuNnDP981IDDEqcG+aXOd+i1pn8W
	 JCh/bt5qPtJVA==
Date: Wed, 2 Jul 2025 08:07:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, johannes@sipsolutions.net,
 kuni1840@gmail.com, willemb@google.com
Subject: Re: [ANN] netdev foundation
Message-ID: <20250702080732.23442b9e@kernel.org>
In-Reply-To: <20250701103149.4fe7aff3@kernel.org>
References: <20250701103149.4fe7aff3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Jul 2025 10:31:49 -0700 Jakub Kicinski wrote:
>  https://github.com/linux-netdev/foundation
>
> The README page provides more information about the scope, and
> the process. We don't want to repeat all that information - please
> refer to the README and feel free to comment or ask any questions here.
> 
> And please feel free to suggest projects!

I see a number of people opened the link (or maybe like most Internet
traffic these days it's just AI scraping bots? :D) but no project
proposals were added, yet.

I'd like to sincerely encourage proposing whatever you think would
benefit the project, the community or simply make your life contributing
easier. I spent some time last year trying to convince LF to create 
a "participatory budget", to make sure that the foundation acts on real
community needs. That went nowhere. Perhaps "the community" doesn't
have any coherent needs. IOW we don't usually have a way to pitch ideas
to $foundations because there are no ideas to pitch, not the other way
around. I'm hoping netdev foundation will disprove that.

Once again, please feel free to suggest things we can buy, sponsor,
contract someone to build for us, etc. And perhaps less obviously -
please comment / like the GH issues if you'd like to be involved in
overseeing one of the projects. Unfortunately I don't think we can
CC a public ML when we discuss the proposals with suppliers and such.

