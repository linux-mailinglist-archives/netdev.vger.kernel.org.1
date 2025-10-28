Return-Path: <netdev+bounces-233674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21F4C17381
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E02400C4B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CF1357732;
	Tue, 28 Oct 2025 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dmc6oUVA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CEE334C36
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691412; cv=none; b=OSc2fsF+im5oey42xdGlRIWrssq+P1TsQDiNQOawI3hNxqP8WBnUJjnNoGRn4JRyFC2RpRVvrCqJAt7nJb6XkCkWv68CU+uPr0QAD9WljxS1yJ6GqDYdKqhsRbVBXHKbLk4xyI+5zGROTCySjiufo3fSsClWJn+DqCGc6RwXWc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691412; c=relaxed/simple;
	bh=kKgj6/+K3fwULDlBSrmBqARm9TfgOT5M9FehHufa7BU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNEJlcnYRK8hxj17ee+7WbvQu8jsiAaE9b3j1SQKHPjWPOlZI3zXeKO1qY7rYH3wovPUBpKhxdMSMGEUPUh3HYHdb0KPz8BEAzu6/PVdBNYA8MN2O+fZpymFCizmnyZvKdBCRt6qCfZwzLww5jy5XdVRFIFYzDAnDg7nYOdxyMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dmc6oUVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF3EC4CEE7;
	Tue, 28 Oct 2025 22:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761691412;
	bh=kKgj6/+K3fwULDlBSrmBqARm9TfgOT5M9FehHufa7BU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dmc6oUVAi3J+1AOzt0W/hmZIfdBoaHqmv7PaBAlfqTfJ6ipPwHYbQzaTa1nIGtT/W
	 T9Wg1oMjdJB5Chp7Unkgq2nHSLoleC2iNrozswVkDm3+xQTjyPC6qH+sZ/6aCvVSmZ
	 2Y3XmRBLz3ZF5bkCFOzw1jD5a3y4QfW3KyzAuQXGB2d85mYr5yBmQWaxJlHbFfAe2C
	 GxNQZU8m1lwRgtALmIJVh88wIku2K8fbTmaAV8rn40u31wj+bUhN9r2+j20p5XyqqC
	 ec8cypXeRibxIgMCd60rW8ViZINTtmLidIXGv9v9BL2qfSe5fEw71wu/B25b9Vz9ze
	 j1m76kUu5yBmw==
Date: Tue, 28 Oct 2025 15:43:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthew W Carlis <mattc@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, ashishk@purestorage.com, msaggi@purestorage.com,
 adailey@purestorage.com
Subject: Re: [PATCH 1/1] net/mlx5: query_mcia_reg fail logging at debug
 severity
Message-ID: <20251028154330.6705d2da@kernel.org>
In-Reply-To: <20251028194011.39877-2-mattc@purestorage.com>
References: <20251028194011.39877-1-mattc@purestorage.com>
	<20251028194011.39877-2-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 13:40:11 -0600 Matthew W Carlis wrote:
> Whenever a user or automation runs ethtool -m <eth> or an equivalent
> to mlx5 device & there is not any SFP module in that device the
> kernel log is spammed with ""query_mcia_reg failed: status:" which
> is really not that informative to the user who already knows that
> their command failed. Since the severity is logged at error severity
> the log message cannot be disabled via dyndbg etc...

+1 from me FWIW. I wonder if we're hitting this on the same class
of systems but recently this started hitting at Meta as well.
Millions of log entries a day because some ports don't have an SFP
plugged in :|

