Return-Path: <netdev+bounces-136169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087419A0C41
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 16:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206A41C22600
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476A209683;
	Wed, 16 Oct 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmcwJW5A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51A52071F8
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087684; cv=none; b=WP6lf7JcD7T8YvSu5eApDlRwPbBfsiUfdYHAbgQkxjIw/TU7AKMXdtzvCfdQeUvNaDsFN8/6pBWOy5+nwTqcI3JJ7VXjwWjZCBiEqIm8shuP/LF+rktjEhEmsVDlnOXoS7a1TGGi9pfHSf8pPW9R1rORIeDtjmV7BkpJukFsZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087684; c=relaxed/simple;
	bh=YJb7jOxNvPen7eliGeDkkFl7TsI2KlHf2qUGmGG/Cro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQjeM9r5GDDh41Mi3MfPgvLqJzJ4i4hsvsYsBSVtlwelI5UbN4jsrjez/SixgwplcjJrR/9eW+z3JBp/1cV78IgbU+FpWLNZR0uhB4nw4iKDP2WB88BFOnu/D5KugIKJruLdrkjwhsLyTH6jdn+6sem08nXV51eE8sn05m1Rnxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmcwJW5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A09AC4CEC5;
	Wed, 16 Oct 2024 14:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729087684;
	bh=YJb7jOxNvPen7eliGeDkkFl7TsI2KlHf2qUGmGG/Cro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmcwJW5A1Q12KT+3Wp6uTzsBHZsaNUYBId4CpVXdTeRza+r2cl4da2ZseH3qJHQkg
	 DrBiT+h/+mqWGs1/IEdJLD9Gcz4bX5DtTx+oijWWMFVAgK5kSwZla48ZumI0FAnPtv
	 LaMHzXSEkJ9lFSaWrNnhAu5b/ZLnqOaoFOZoIedEgHLA6jBc6M4WHra2Ohl2zRhCJe
	 Om2C9M6hkciciGqxndlNuhfwBZ3OA59imopuh+atkCzjVY8ekuzF7RJOBgjiWH3T0+
	 kY6pCTq+hwycMuF+yKEv7JRxHhjjiPtN5aZGL6Ov2ak6m0Od+MPCE+Z0tqIZQPfQQZ
	 vMwEkZUnUa6Ww==
Date: Wed, 16 Oct 2024 15:08:01 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net] MAINTAINERS: add Simon as an official reviewer
Message-ID: <20241016140801.GG2162@kernel.org>
References: <20241015153005.2854018-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015153005.2854018-1-kuba@kernel.org>

On Tue, Oct 15, 2024 at 08:30:05AM -0700, Jakub Kicinski wrote:
> Simon has been diligently and consistently reviewing networking
> changes for at least as long as our development statistics
> go back. Often if not usually topping the list of reviewers.
> Make his role official.
> 
> Acked-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks for the kind words and trusting me with this role.
I'm happy to help.

Reviewed-by: Simon Horman <horms@kernel.org>

