Return-Path: <netdev+bounces-213307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F28CB247F3
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D47169334
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26692F28F4;
	Wed, 13 Aug 2025 11:05:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D352212556;
	Wed, 13 Aug 2025 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083152; cv=none; b=BB/WqlE4/5AaxzVaKLhd3hdseLD3XptZEIFcY+4hDv2gJhuRoHbYhH5fqVce1LMEv/T9r0yoRk+rto/v0JvKZcswjRddwv7r0zuQKjVO5gxC6hsN5Q0LaluW4yDKv/zyilqJohax0m2hOhhx1zFuVKl4VIPLVlYOYplzhdibNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083152; c=relaxed/simple;
	bh=19jXmdm6BoKJpJdC5a9g6HEo6t347g42HYUDu6mtFcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+frOJGXWGb3VAklz9bOUnYyxAarprE9QRRLpEFunxf4DgZTASMVyFGSb79zd5xb4P3SpJtYRaa1nq/2/rQe0PUP+YkLZbWeh/XEX7k2ecSk09rlevQRu9yRe3XI43Sad1hokobCuatF0PCV1hVcWYHhiyIWGFqVcsIWm3y13n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5393776550aso5203109e0c.2;
        Wed, 13 Aug 2025 04:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755083149; x=1755687949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8ELOPdoTkU1ViN1av56fzFnprM3B43pI8SDG5/ljkw=;
        b=Oo8JVid2BHwTsZZ2S+6hPyEOMI85nsvrZA4ohy5RMI0wOp4cLgqwhSEUQ+rAUfhu67
         6YfSqQGQ2zpQdIxLb789dSsRRE/b/GUSqZx1qI6UMNWjWndGu47IpO4HLeJg/cLSUPdk
         h3JWW2zXosBJI/pk6IGDLmKiS3VO0mXacaNT1ATdD3/MnZz7FCOUMT5qy/zKlqsj1rgE
         CTpbpiJFfKWlGQdMJ0hn7G8GC6pivhvJzJ706eD3xFGULTWJ4xs89+ND0FOsdEVKZhn8
         PFQ1Hg2a6OX9n5jrYO42bHxbTkgUxJiSwhA3xuv9JSRodfJM8NP8UHqMXtA4NAXEvxYX
         qTsA==
X-Forwarded-Encrypted: i=1; AJvYcCUN6XE4jNVrKcfjcoscHGb/OYhCfoii6CmfOJmF+VOr8teikzJ26+VLhPhrZddNrMKM95LJ2HWEG1E=@vger.kernel.org, AJvYcCUNndM+ylBLNMXLjP3QjSeNIuZ9wGu9Rbz4LjpEoSntEfrBWQsPEabWIZkj/B8lC7hFNILLgDzZ@vger.kernel.org, AJvYcCVC/wxkt8e7cSGWj+0eBwF6kbidlb6t+ht9bI5SmO/yxAcgzEcpdXJYyWqN0UmzwIBg/pXRnUBG95AZid4l@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCikfEbx/uwpdpcA5Oe8WlpNA0/LKwIBKT3LQg78YdwcGw6LX
	xRLU001t5bTb0UAdjkeY7EJ4VA1AIJyCTuAQdYIHQGVrxM96Eg9hnPy+tvT/1xAl
X-Gm-Gg: ASbGnct7QdSL4H0zJC6badrvWl8ZQso7HSNFmKiZxaD8kj2u/S36Ec1eIUK0O+UncBA
	rz0UOt6wuhL6SJr+4KOYWVFXfXQPi7Mv6siCNI8q4zeOubqLEb/3pwhSQyu+VihDR968tkLz+HA
	U9LVsTYV0tr/Q8q1/8F4snnqLICLVOsljLiLIubBhMeWX3iHySmfOvx81WbtkMbFTWq84jw+yg5
	55X0xMtZgN+h1F4U0ax7NmeCaYzL622Ow5MWgnF7cMe/wTTXGr5GxjwvtEfB/eNSbyNYSu69Rs2
	HIdHQcgsQSSCkYbzjb2S1B5nXkWPFVyu979idNXekEFWKKtZVdApHkKiMNL/emOVrEYma47thGB
	03O52ajvZTzrsuE9fUaO+y1KRVYdHWwpFZ5PWO840CMUYsNAsHzgUfdInYP40W094Rbo5PEo=
X-Google-Smtp-Source: AGHT+IHCp9iHmw+2YssG/6jmJcp5qBG7z2xggb32mHp/vuskeqUU/2pYN1s6ZD7FjQzzn5k3uMdH1w==
X-Received: by 2002:a05:6122:512:b0:520:61ee:c815 with SMTP id 71dfb90a1353d-53b0b6075cbmr728257e0c.10.1755083149119;
        Wed, 13 Aug 2025 04:05:49 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-539b0289540sm3776384e0c.18.2025.08.13.04.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 04:05:48 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-506374fbecbso4053949137.0;
        Wed, 13 Aug 2025 04:05:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIa5YKQqFqV6g9Bm9WKbupXJBDSUN3RLWBPmAtGIXWm7tSv9niygSdjb+8r+Cud/X4xZMP0L+tPRA=@vger.kernel.org, AJvYcCWSwBtuDQizZVq4hRxa6WQ+6bKaDTrcDkQqkxR65n58KDZhXcNo3UfI8GmEN2H0SCtrA9o8yLTlh+PL9RXJ@vger.kernel.org, AJvYcCXpwAtNFyYCErMV/4AfAqvd/Hnoy1gWQ1VHBVf3iuNQJgaKY2Rf6KqDVEHrsbpzyYN3Kqui5WN4@vger.kernel.org
X-Received: by 2002:a05:6102:80aa:b0:4fa:25a2:5804 with SMTP id
 ada2fe7eead31-50e4ede1dcemr1060597137.10.1755083147792; Wed, 13 Aug 2025
 04:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812093937.882045-1-dong100@mucse.com> <20250812093937.882045-5-dong100@mucse.com>
 <eafb8874-a7a3-4028-a4ad-d71fc5689813@linux.dev> <9A6132D78B40DAFD+20250813095214.GA979548@nic-Precision-5820-Tower>
In-Reply-To: <9A6132D78B40DAFD+20250813095214.GA979548@nic-Precision-5820-Tower>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Aug 2025 13:05:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWpmt2q9tVm-3HV1h2=-7D6zEs_HnBe5gfYVgvfB=01hQ@mail.gmail.com>
X-Gm-Features: Ac12FXykxkxcBAyHi6ifzzajziMNzS1hRo0bp3BpLatMabyGlraJlaV0atHk_h0
Message-ID: <CAMuHMdWpmt2q9tVm-3HV1h2=-7D6zEs_HnBe5gfYVgvfB=01hQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] net: rnpgbe: Add basic mbx_fw support
To: Yibo Dong <dong100@mucse.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org, 
	geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com, 
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com, richardcochran@gmail.com, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yibo,

On Wed, 13 Aug 2025 at 11:52, Yibo Dong <dong100@mucse.com> wrote:
> On Tue, Aug 12, 2025 at 05:14:15PM +0100, Vadim Fedorenko wrote:
> > On 12/08/2025 10:39, Dong Yibo wrote:
> > > Initialize basic mbx_fw ops, such as get_capability, reset phy
> > > and so on.
> > >
> > > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > > +static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> > > +                             struct mbx_fw_cmd_req *req,
> > > +                             struct mbx_fw_cmd_reply *reply)
> > > +{
> > > +   int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
> > > +   int retry_cnt = 3;
> > > +   int err;
> > > +
> > > +   err = mutex_lock_interruptible(&hw->mbx.lock);
> > > +   if (err)
> > > +           return err;
> > > +   err = hw->mbx.ops->write_posted(hw, (u32 *)req,
> > > +                                   L_WD(len));
> > > +   if (err) {> +           mutex_unlock(&hw->mbx.lock);
> > > +           return err;
> > > +   }
> >
> > it might look a bit cleaner if you add error label and have unlock code
> > once in the end of the function...
> >
>
> If it is more cleaner bellow?
>
> static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
>                                   struct mbx_fw_cmd_req *req,
>                                   struct mbx_fw_cmd_reply *reply)
> {
>         int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
>         int retry_cnt = 3;
>         int err;
>
>         err = mutex_lock_interruptible(&hw->mbx.lock);
>         if (err)
>                 return err;
>         err = hw->mbx.ops->write_posted(hw, (u32 *)req,
>                                         L_WD(len));
>         if (err)
>                 goto quit;
>         do {
>                 err = hw->mbx.ops->read_posted(hw, (u32 *)reply,
>                                                L_WD(sizeof(*reply)));
>                 if (err)
>                         goto quit;
>         } while (--retry_cnt >= 0 && reply->opcode != req->opcode);
>
>         mutex_unlock(&hw->mbx.lock);
>         if (retry_cnt < 0)
>                 return -ETIMEDOUT;
>         if (reply->error_code)
>                 return -EIO;
>         return 0;
> quit:
>         mutex_unlock(&hw->mbx.lock);
>         return err;
> }

Or use scoped_cond_guard(mutex_intr, ...) { ... }?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

