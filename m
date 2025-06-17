Return-Path: <netdev+bounces-198499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8787CADC70A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5271A1899CAC
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667642BFC67;
	Tue, 17 Jun 2025 09:49:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DADC298261;
	Tue, 17 Jun 2025 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153779; cv=none; b=L6x1IAP1lK50L//yAIgKvE2ZFwotj5MsAL0Y7fmBG331h0KVx05KoNae/Ic1HnvqROycANvXZFkhjQoNctulBvJv01iO3Jn8BLA1ceNj3BjXog6gU/HOUHtqzK8LXK4IoN2leiqAcLs2sDrTV9nak7vzwpR0LMTiHLLe7VZuejo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153779; c=relaxed/simple;
	bh=DP9DqrgR2bh8NqZ6FizF/KGOAPXqqAR5joYEFv95tPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uedlCDYpD+3CH6ld7duzvZLHItkIBlMailGqfTplwC4gLcQTIjIqv29Zrvg8mP62RQeLmn/HDWkV6aJLnGwFKYoeW6iAQwtncXTOd93iPNQQRYO8E4rklgR3oOfuXYZdJQFVf0LHbCABWcZnA6sH1mvX7RC3B63yXFbZlM3snqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ade5b8aab41so1173964566b.0;
        Tue, 17 Jun 2025 02:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750153775; x=1750758575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNjpKIWFUO3UwHjqSrvxZH4sVoUp8DK07nEW60sO6KA=;
        b=CHpiGry8Q9/+676xvBpi9YHXz3JOH7iu+FTbEGuFaoKNmZyinPXLld8SaFu5uVsUz8
         JFmV0SGBHvQmdi8X65jUlfPDh87icfkRZZuMRGnHE76M8lR/lZPCWd6K7AXHtNg5Y7Hp
         /qd6h9gAL0/pm1kvmgl5aEi+dLDgd87FPFN49QP5QaRO5xSvYCyqbd+0K1N9SB3e75vl
         CdvWM2N4r4CgoperwKaTfdN2gfgCWRWk6ake4UAAGWMBl4in8OeQgMlkmTwBdPr5EA7Z
         5RAttYXla27JfFdI6z9mPJSUp+18XN1g1kJATdfNJ+bUr9U1dNkPvTuba03l6rz1uIF4
         bkOg==
X-Forwarded-Encrypted: i=1; AJvYcCU/jFyWPiDWOWQJqbjou5GxJexqbguN5nxxIGEXkTor4cGfbD4MUiQbllpQmkFKQE5VFr/kP5Ir@vger.kernel.org, AJvYcCWxeVHkr+LkTOKiHnquPBJbKtDZGg9MGqBUo+CT4wi8t7oHRwiRe1B+iThfSnybV2wvQHUQUqHJdzhS6Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzjmJcpjHHusFvhfc2+8gkFNeBb7ykDhARj2+3/2dNOSKgTyjm
	cNjLCyOPA6U7EqB+8rjhLv8M7uZjpblkTrCG/zA+vfW5eRoi91dy0ngk
X-Gm-Gg: ASbGncsb4dSXrBnGj40vYFDA1pm7jTET0QFgF20BpPULB8VohwJSRywOiAajAcicOtS
	JuWvWrjB2H4Vw77i5F7ahp9OC02WaufPqPbB5C4H3Nqdh21gImNlCFp22WCur2FLw2wXAm6dqmV
	JatzYodJqNRBlooQ293pZBHJQTwhMPaXC/YKK5C6mJ+KOqwOxCgjjxF8D0+8NvZuBlUixxISWq5
	5aohAf1IimLFpjDjE1nPdqsmdJnbtU24zQwbS45TQayfCgYxPaLYRMveCt4HXAuRvMEcOrrRhQd
	p0tZWlLJNK3pg85u3FcrYy6aJ5/y6pFk4faWEiXEdGpaY3xsrbBZnQ==
X-Google-Smtp-Source: AGHT+IHW9294E3OtqJ+f28GiD9wYZ86H8EQy05fIL/mh1QaSIzEMnsqq5NiG7/2VBActvbbuMbdfRg==
X-Received: by 2002:a17:907:1c0c:b0:adb:2462:d921 with SMTP id a640c23a62f3a-adfad277532mr1325684366b.5.1750153775307;
        Tue, 17 Jun 2025 02:49:35 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81c5c5fsm843320666b.63.2025.06.17.02.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:49:34 -0700 (PDT)
Date: Tue, 17 Jun 2025 02:49:32 -0700
From: Breno Leitao <leitao@debian.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ignacio Encinas Rubio <ignacio@iencinas.com>,
	Jan Stancek <jstancek@redhat.com>, Marco Elver <elver@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>,
	Shuah Khan <skhan@linuxfoundation.org>, joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: Re: [PATCH v5 09/15] tools: ynl_gen_rst.py: clanup coding style
Message-ID: <aFE6LIpZsFfy3rRU@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
 <b86d44729cc0d3adfdddc607a432f96f06aaf1be.1750146719.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b86d44729cc0d3adfdddc607a432f96f06aaf1be.1750146719.git.mchehab+huawei@kernel.org>

On Tue, Jun 17, 2025 at 10:02:06AM +0200, Mauro Carvalho Chehab wrote:
> Cleanup some coding style issues pointed by pylint and flake8.
> 
> No functional changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

