Return-Path: <netdev+bounces-70799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F20385078E
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 02:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C19FFB23E2B
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 01:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A61215B1;
	Sun, 11 Feb 2024 01:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b="yC3tsZ3v";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="fW0lsaW+"
X-Original-To: netdev@vger.kernel.org
Received: from e234-6.smtp-out.ap-northeast-1.amazonses.com (e234-6.smtp-out.ap-northeast-1.amazonses.com [23.251.234.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7A7ED0
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 01:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707613741; cv=none; b=gAHFJL7sCKU3BnXCdH0DgWy3UGHqVMOAKdZF3G3u9haszFsoPdCTqHmRRbbiP98eih0YREgj2xkEYg46lRPqf3VSMtQ9raH5wmN85NNAfhZAd34a/AOvGyD8+ZJT8hyVllmzEJRkzdsJ5EyECDAkKdPY6Fz77uyFwV3pLpmMurA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707613741; c=relaxed/simple;
	bh=4viEG6/q2sExQAG4GhkyIqN6WqYoe/i9rDrJo9DEYWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k25BMlY4i/Vl1LXz3qs5Ts9CTQ657Umry143fUcQnvKKO1vrK5QHenQlC4Oal1TR4r473MShOmkLuO0b5NuOeBifysqnB0mtamjwuqJ8FqxVXMC0EihLi1jutm+gA32mPK4zJIMzxZWwg+JX274GB2Du/SOtyOAzfohjLzDxR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com; dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b=yC3tsZ3v; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=fW0lsaW+; arc=none smtp.client-ip=23.251.234.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=otpfqkfjftndw3gmuo745xikcugpdsgy; d=hrntknr.net; t=1707613737;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=4viEG6/q2sExQAG4GhkyIqN6WqYoe/i9rDrJo9DEYWE=;
	b=yC3tsZ3vAxZH9S8yL9O6z0Lf+lPAgeoxRw84+7Tnno0ptTHb013mB+6G98NcoEpw
	5p0pXkcRyUok+Jewt80306H+1jT2DbLVAlfa/29SAA67nZszG7cjnG2EDMnD0q+4mC5
	d76BAFn7Q6yW3qbFseXE8QbcZrVGboIWza6o/bf0fZ4dPK6GLMyQU4iu8Gl7os9+OhK
	7SSirElLHtwJiq4SlYYp7MPewYtA3UV/J1zsunhQ33rj8rmMNiIqEm0EzTpmVQHoaaU
	rsuo/Lv4DL94E5QOCR17xCNuou2uKs87+4UU3l2LhYYxXzKSb+F6hOaj2q+2HHWP1P/
	cj4ggnzSVQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1707613737;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
	bh=4viEG6/q2sExQAG4GhkyIqN6WqYoe/i9rDrJo9DEYWE=;
	b=fW0lsaW+is90Ia+smT2FUSAmWmF8pOVikE7wyOtqachLVTr4rvb2YCm4Jc/q8Co6
	GKo9OoCS8vx6FynouQDGxslirTdhVRlsRUI4cIKubwslY4uL9wzC7GzHvGelYNh011r
	ftKrlLsiwUxqFqS5ZB2Lr6kx4sKa9u9f9gNIB4fA=
Date: Sun, 11 Feb 2024 01:08:57 +0000
From: Takanori Hirano <me@hrntknr.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 v2] tc: Add support json option in filter.
Message-ID: <0106018d95b5d2c4-b1827da3-cb5d-4660-98f4-d6d7c4e39db0-000000@ap-northeast-1.amazonses.com>
References: <20240209083743.2bd1a90d@hermes.local>
 <0106018d927d04ff-efbd5d4b-b32f-4b39-a184-a28939608096-000000@ap-northeast-1.amazonses.com>
 <20240210170055.30fcea14@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210170055.30fcea14@hermes.local>
Feedback-ID: 1.ap-northeast-1.rx1zlehJXIhTBJXf7/H1gLdwyBf0eKXp6+AKci1nnIg=:AmazonSES
X-SES-Outgoing: 2024.02.11-23.251.234.6

On Sat, Feb 10, 2024 at 05:00:55PM -0800, Stephen Hemminger wrote:
> On Sat, 10 Feb 2024 10:08:03 +0000
> Takanori Hirano <me@hrntknr.net> wrote:
> 
> >  	}
> > +	if (tb[TCA_FLOW_MODE]) {
> > +		close_json_object();
> > +	}
> >  	return 0;
> >  }
> 
> This last bit is problematic, the JSON encoding should not change
> based on whether flow mode is present or not.
> 
> Also, brackets not needed around single statement
Thanks for the review. Yes, I agree with that.
In the v2 patch, it was present because I was using open_json_object to open the map/hash.
In the latest patch I just sent you, it has been moved to the "mode" key.
I have also removed the close section because it does not do json open.


