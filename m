Return-Path: <netdev+bounces-287118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKHsNAIeA2r10gEAu9opvQ
	(envelope-from <netdev+bounces-287118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:33:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D4989520340
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C95C3026352
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F302038E8AA;
	Tue, 12 May 2026 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFlF2ZxE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7740388886
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589036; cv=none; b=tM9k8VLonLXNu5PyA86z8nQQ/8dJTWpWzl+3TPYOoqZa0Ruds2wyyZ8u+nkmbAbA8m9LupR0md7dhehyRQ5K1gX+bbRkgA5u2e+qcqzq5nlIF/v6FGyCehwcQpvQWPabMylUkMw7+nqAAQfl6RgjKtCmuYblF/ROViQnXdM3Gzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589036; c=relaxed/simple;
	bh=uDnDIcInIh/GZHu8GVNkiLMvWqBYjU1zNoFBLIiO81k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leCmCjgwB0B10Ns04p5R2BtBuAOvUTf1zIEwYoDYHf4OHO7N66LavpC0sYPpWzIwT3hloIYouhXNYHWZMlEVMjOEL5sREOzrwsuFwrCU4+jbrH5fqxmMe6HYJpzSDnMQxOHUG5WZX45kWl+LmNzhT9WM4uyO0gxTU7ekQM1HH/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFlF2ZxE; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65c0bda7f15so5689877d50.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 05:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778589027; x=1779193827; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uDnDIcInIh/GZHu8GVNkiLMvWqBYjU1zNoFBLIiO81k=;
        b=lFlF2ZxEI1LabPdBLrbpCn+vX2TvALaLhaZV8E/RWI9IuOXR2Lya17HyiJv1b5yRya
         J+4EHu4Yun9YsKAJ7OfA4YEfDfruxQvo7ktQwGw6T9hh1+eYGffQ87Y7zhmiE0D4SbwS
         KSN4e8wneYbgW8d6rIMmlGJ505U+C4Nq7OqTEcufRS2jLMAuFk8LvCpIjmBDcGvN6twE
         /SppKi0CEIvC44quiRgCETQ1UVLHrr3o0+uJ98YEbmU8H60vFJRqEDdmFEiUA8weyAPG
         55IRviWj00J4vJKz60X6aiMiFVomaMXeOiahUPIiXNVyRbCVsK+ruDGMxwyu3XpiqeKF
         MilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778589027; x=1779193827;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDnDIcInIh/GZHu8GVNkiLMvWqBYjU1zNoFBLIiO81k=;
        b=rJfx7UjC0nKCy71roon8862KozujFaNxqzt9NQs/sxSBE0k0oIs6BidFA22wXH+j3G
         Ok32L3ORIs2lQuIoCs7GEoaB6ELdZFdfG+yqUzYbcyfl3M1SNrCKDsV1IC08dobx6mwi
         Z7VyWin+70XM5qKqTyyi/YcXQLhMlPGk/4Xj/pkV7NVBtQpJZse5csBHHwyJywVcr0u8
         te7VtqRa9vL7adRa9ENA8eDeT64tkOWnDd9TgKOT1mnj6Co2yNhgfHjwkCofBM2PANtb
         3T0fGGWUzEuDxpVB0YNc4DMndxCQ7XX+OZZNBbtwyn7aK43QQJF+eaAgqI376id9d8Yc
         6DXg==
X-Forwarded-Encrypted: i=1; AFNElJ+wmBelIaKfplPNpsakpvpwGLZFcJEroJVPegqiZzSPDjndMXegj1jRhwX2tlQonn+YQG3B3jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjV3b9nYujZG3vd5D/SR9PWK/Aks4kzqt1Rn/Yl3OBdYSo8qL9
	d5EiuY1ArxRknjHKCdX6+X1TQdtAWh+YmXz1aEwJIxk8dd2p56kQRKMi
X-Gm-Gg: Acq92OFoh/rcmC31lXQfRHBPc7OTIVcN6ANf8b+hKUJ0iKQORpIrDl/BO60Xsz/Ri1f
	BQbotiFTYQEdtKCoUJ8uBH20mFjTbsrMRobjmt7zC0BZGP4l+HG4xnsgTlag96Kue8vLI7irafe
	A+Ppyx8Nak4Ve1g8ZB6XCMgnPxbrUv3OOObQeBhaWzj/+HYLZAQqG9IcJQJ8+l4r+knmy4lpqME
	ghRE3QEzIBdmf0Ygco1LJqI/r2SJhPwfZrAD0TDVBMlplvrjiaZGmfKib8xBxznQU5RhDX+QhMB
	e6s1feLM/hWvGsrrFuklz+fuGFA5sHx2LklYmhTlf8OK4iekAv2Mgk3wSmXWNvi4JH5kSQNqXoj
	SbImuJbiYvJV13nD88Cxy7vNZA4ldCpu6HtnmTxO9VnlcqCzVEns7p1TGj8kxVEI8Bcu+TDYTwV
	8pl8mufhUc86PAgV2sWxNQF+U7FDRDef4v104D
X-Received: by 2002:a05:690e:190e:b0:654:6ccc:69e9 with SMTP id 956f58d0204a3-65da85cb8a8mr12398583d50.51.1778589026928;
        Tue, 12 May 2026 05:30:26 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96bf418bsm7052263d50.17.2026.05.12.05.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:30:25 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 64CCULti023887;
	Tue, 12 May 2026 15:30:22 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 64CCUK4T023886;
	Tue, 12 May 2026 15:30:20 +0300
Date: Tue, 12 May 2026 15:30:20 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/6] net/ncsi: harden packet parsing against
 malformed BMC replies
Message-ID: <agMdXKQgo3jEWtXN@home.paul.comp>
References: <20260422160342.1975093-1-michael.bommarito@gmail.com>
 <aej66UTWzQ74dven@home.paul.comp>
 <CAJJ9bXyoAND+CzLqY=jGWdtaY33jeLWf0sBbj-6OXHyXudqjUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJJ9bXyoAND+CzLqY=jGWdtaY33jeLWf0sBbj-6OXHyXudqjUQ@mail.gmail.com>
X-Rspamd-Queue-Id: D4989520340
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287118-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,home.paul.comp:mid];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fercerpav@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hello Michael,

On Wed, Apr 22, 2026 at 01:06:56PM -0400, Michael Bommarito wrote:
> On Wed, Apr 22, 2026 at 12:44 PM Paul Fertser <fercerpav@gmail.com> wrote:
> > The code your patches modify always runs only on the BMC itself, the
> > packets parsed are generated by a NIC directly.
...
> Should I submit a v2 with the corrected notes or wait for any other
> feedback / review on patch substance (assuming you think it's actually
> worth merging)?

So I see you got some interesting AI-generated review from the net
maintainer Jakub on 23rd Apr. That raises many important points so
please take time to go through them manually and respond. Once some
sort of consensus is reached feel free to send a v2.

Thank you for working on improving this dark corner of the Linux
networking, I hope server manufacturers will appreciate.

