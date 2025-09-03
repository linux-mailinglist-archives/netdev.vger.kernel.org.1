Return-Path: <netdev+bounces-219639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DB1B4274B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9766F7ADE0B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE8030C358;
	Wed,  3 Sep 2025 16:52:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9263E2ED860;
	Wed,  3 Sep 2025 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918324; cv=none; b=cpPvaOREnpuEZVFunAuZ4GsapbfbX0iN/sR2gUWMYwDE6C1uzf0soTHkyz6E4T9zX4tS7v8VwVocwvtCZtzK7s8AdvlBrVOLNID2k/kfOPXydruf19VAMnWICRAJtbhGVxlcm4iQiHRP/ZfyEkQbkJtR47lbjvjGOW0Gaf9J+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918324; c=relaxed/simple;
	bh=SC4vvCIh6HVYZODXSXSISU1/mNuZk8irrLwPdBkb1LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9V47A+3H7YqJBhdmEGWrfYrbx0WM0hJtmscx37KZtJn6S1+YthOWhJK0s6pfIPcw7K5hvmZkdRACAwaBMbqL6SpuWXUypFx14Mmm4fb4RzE0/LsB7SBtLKuPcy6Wqqd1UskcpI5dHV6bq/Y9WTEDI8Hu+xDpME6oPKyI8hLDbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7322da8so21298366b.0;
        Wed, 03 Sep 2025 09:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756918321; x=1757523121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TS8yFqssheDT5JhDABA5pXfJxzkDyZX8nmQKjAuFt9o=;
        b=uWgV48j9dw1mzIMUpKlZrmnC6pmCxNXNMJVhU2bl8VFj64tOFCq1jDW+9bBD7s82m9
         zrN7q3kSSxVEwNMU+WCZOgneRQAS6M1gEzv/HEGwWriCpy+qeJFIt715o4LXRK1WHxZu
         KKaPG7exy4ZVd3Och+LSuEmcASNRXtNML/DX2L3Son2QprjzdOv3CwNhYebnNPotvmSs
         WYzcgcniAsKvyBXPNi5PcaDSkzdjswPZxSW6FyJRMRcquu+gh/AAgmAnZGnLVPs/ziWz
         a3/TeHIGDmRAFtfzcnQOkEK+oQRbxxUMWuxa1A7fckgDMjOxRslVwaEmGb1IkvuXT5m6
         p+Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWEj8kKP3D+ThE1lvT3wtJfpjwbi6Hl3dpAsRbQMdUbOejKwoCdb6gE1N1w0ttFjASHg9EVK/V8ZwWp1z8=@vger.kernel.org, AJvYcCXj7403LWroF7OJ7aoMArr7KGH1JaLxuAlh1hw6lYNs2IZt/Q2MI+tyO9p7fzB+D38vMe6RY0Ae@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdw6HdRYL4Gl0XgEvXZqPsktk16P09sUz33LFz/KNJr5Ggibcp
	mKZ9pKPcgt6RzzKDVumOK/HFBMBlXAYQKjRCVAEkinqlmi1+GfnVIjIR
X-Gm-Gg: ASbGncubR9Aoufc89tohjdFyF/LLN05fr30A/6EWteqWmhnI0ZkURsM7zGAErdAZ7C2
	JkUs2U6ejT621DpawbTK0NMamizyTQeO9og0dZIG/8ifZwUOC5zwNguu0lAan7V3oFaSzOJcUHN
	hjsqNkubgXQFlKETLS2tn5FFSBoPHWRjW+b4PjyHIZF9RSoiIyvdW54KcWKxM1IVDpk11xtMk/o
	VyUNJGbW5A6NXDOFJYBk9gaS+znMVtAwX7zKSOvgrHYo/hhAbJjmpUeX54JwypN2hoLdLSl1iVh
	Q4hUuW/3y+8UNnwPXRBOVfOx3/NgpVc0kYZTpcOd51I3iuA2O1ESTI11hNtkMRCah//aYYPEf0v
	2N7V42LZzTUYEFH+WfYTQ1js=
X-Google-Smtp-Source: AGHT+IGGflStVCuHzCFsc78Vh1Q6ajVQk9iXe7sBDgr5P+ldeTJ4+esXOhqB9adB4iccLVfZDfPKLQ==
X-Received: by 2002:a17:907:2684:b0:aff:13f5:1f0 with SMTP id a640c23a62f3a-b01d8a26e65mr1488688866b.7.1756918320662;
        Wed, 03 Sep 2025 09:52:00 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046df9a44dsm153072166b.70.2025.09.03.09.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:51:59 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:51:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, kernel-team@meta.com, efault@gmx.de, calvin@wbinvd.org
Subject: Re: [PATCH 4/7] netpoll: Export zap_completion_queue
Message-ID: <v4bz7lyzs6f6mlfhvgy3p34sihu6sojwntbev3hz2sz425j76i@wanin427lov6>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-4-51a03d6411be@debian.org>
 <willemdebruijn.kernel.9ee65133b4b7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.9ee65133b4b7@gmail.com>

On Tue, Sep 02, 2025 at 06:50:25PM -0400, Willem de Bruijn wrote:
> Breno Leitao wrote:
> >  include/linux/netpoll.h | 1 +
> >  net/core/netpoll.c      | 5 ++---
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
....
> > -static void zap_completion_queue(void)
> > +void zap_completion_queue(void)
> >  {
> >  	unsigned long flags;
> >  	struct softnet_data *sd = &get_cpu_var(softnet_data);
> > @@ -267,6 +265,7 @@ static void zap_completion_queue(void)
> >  
> >  	put_cpu_var(softnet_data);
> >  }
> > +EXPORT_SYMBOL_GPL(zap_completion_queue);
> 
> consider EXPORT_SYMBOL_NS_GPL(zap_completion_queue, "NETDEV_INTERNAL");

Thanks for the suggestion. First time I've heard about the export by
Namespace. I suppose then I need to have
`MODULE_IMPORT_NS("NETDEV_INTERNAL");` called at the caller side, right?

--breno

