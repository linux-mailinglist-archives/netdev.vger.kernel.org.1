Return-Path: <netdev+bounces-44869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960737DA2AE
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C252E1C21178
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC52E3FE51;
	Fri, 27 Oct 2023 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTETYzrY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130E3FE50
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 21:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2058EC433C7;
	Fri, 27 Oct 2023 21:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698443660;
	bh=nE+0Rp3RPkH3TN5q+83SQpyKgTmRbYNv26EjTXo9D/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kTETYzrY+RCjdJAsEyEvP7hJcgJEr/Son7Az4zgZePX3o5RmIA6581hhjA+1h3XOR
	 Z71QkMrd5Wz+DBOUlApYHQZSIW1LlWnVSeHDTlvmX7HLon4IiWnWHlqrG6cWB+1J5i
	 rCZOTAYjk5okXclRgECdQEHG26arYZ4VoxH3lGoeGnFVRLb/zlHP89ki8fBkIDNAov
	 yXKNee4AogISHrcfyGog4N3PdYptZBJLn/YByc3T7z40rJXaPwVEmChzamvyJZx378
	 Ku2KjWs233jwZpUKm5vcR815SpSXgF+TB7lWhM8+N3yKgqISntIizhea4V8x1CjV5Q
	 0g539umgmTl4A==
Date: Fri, 27 Oct 2023 14:54:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com
Subject: Re: [patch net-next v4] tools: ynl: introduce option to process
 unknown attributes or types
Message-ID: <20231027145419.6722f416@kernel.org>
In-Reply-To: <20231027092525.956172-1-jiri@resnulli.us>
References: <20231027092525.956172-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 11:25:25 +0200 Jiri Pirko wrote:
> - changed unknown attr key to f"UnknownAttr({attr.type})"

Not what I wanted but okay. Let's move on.. :)

