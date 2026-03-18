Return-Path: <netdev+bounces-269109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKUzHdPfumk3cwIAu9opvQ
	(envelope-from <netdev+bounces-269109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:24:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD502C033A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB8193258505
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B203AA50D;
	Wed, 18 Mar 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5HEUmxl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8F3F0AA2
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850916; cv=pass; b=uVsKJWLj02sKTC8K6Re+/A3yYJd84ilUvZ8AcfMDy2D2uHZj1wm/yMGWBdnZ5hFpOe/zvXuopL0+fXtLn+EsyhJsa7ROyGvS6taTprmYe1q8LtwHhzYinAtBJI/x6DECgYEFU2T+DplcaCNIqvsm1IJToMRIa1BHAMGgvnRp3E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850916; c=relaxed/simple;
	bh=1mY0vMdx3K8sY9OrMLKo8bHAtDNNQrwI+eIMWXDn2W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWC7vw7t6AkLVWzGGreWKLRabH+YHUFbOZl1/pXqrzdl7Sh8gJZR5JxpgKD7AqP32lREuLHZTzei1QBwslO7+51G6UBBmm03LCtvtvotn1gUnNgJcJ78Alk6puGIO3qn21oo6Nl20a4RxZoHHwIiNa5cZPKkOpQ0LYpSN9QDFtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5HEUmxl; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56b91ead558so2432774e0c.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 09:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773850912; cv=none;
        d=google.com; s=arc-20240605;
        b=g+o1e5LHfeajelLbs1MdXQIiy1li6FVNgIqM7Fn8IZyRa8lY2Z0+emA3zr66ce3SYw
         Bvs/kGd8/WMSJkjkOVEqTgnivf/mSrrn60SoAV/ex99TlHR/7EXESfnDhiwquiLlwzeQ
         sqj5SQlSYz4V3QIPVh0EFlbuCqbMkAJtjEX2f38eFqfwPh8ONwaPN7sxpuLwpojv3N6e
         pwG9KfnTV6XByt2oXmGuAOZTOUJ3KQEWvDg8g4WvbqNQniy2bVFMkCwoAIyvupq8AhH1
         YVB6GzqoIwMGVnF1P2oISRtMdLqBX4H8pnri8dervGij0+2UUiN3y27P1Rjhfb53jDI1
         JLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rs2cBqgSI8tXQOKn6mhyxErGd8JeTiXqDOSIJAWUZ1s=;
        fh=b+as+QXHprUyXXskNygbgGiqT5v1Wz3WLc1ohIwWjJA=;
        b=h+P0tPCr3RgWVdBHnAYdwi789iPJu+vpZE0QBbTixMSIOKy+64lF+N+LNDUxY6kEDC
         +dD9y1D+/z/4iuUIFEq0/uqqSh2PTnSmSYb3cWI51W3xx17itJCakxE8lg8LNwDYZLE3
         i2NVg/6ou2UWd0H9Fu+mPzxqjl9P3b5IAgm+Tu+eNQjhH7qyQ2xCScqTvGJ0A3fQkbLc
         xZuddzlOt0/LS7QvSyBigS+1FmY+nfFuDjrSHkeU6mJA0RXocII5YKamDHEHiQfXmGjZ
         RDDfU8XL9scAEwBIE2n3sANh485Lpm7ZO9vk44X7NMlHXe0NrmpCydvezHEmSwz5oIz6
         34YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773850912; x=1774455712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rs2cBqgSI8tXQOKn6mhyxErGd8JeTiXqDOSIJAWUZ1s=;
        b=d5HEUmxlvq3Zxzzz1sv9qgh8UqxH1M9QhLfmQDhv5eAtk7Yb6SNYvp0kGB+EegfCr7
         37Oxxizoz3YKi9aDNNuCdvqXW8LEyw3eznAKab0cydtcjFq4eADYx1QK1e942bMCgLfJ
         xDJZZqHDFPYGpsbsJJ8Ymx7NChyueUdNAd487t1UBlf/a96zyr16Hj+k7lVNl9JyJSLI
         ohWqsRlVTxkUicC0UVSNuoOnPTupxBdqQdkEjJ6EThnz2UfilE18d5KdkdBOgg+ROWhG
         7ucU0CXS4i1elofKqF7OQUVZaHMlcp1lFbXFBKl6n5xmacqijX9gUsrwPmAww4GpTry+
         HFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773850912; x=1774455712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rs2cBqgSI8tXQOKn6mhyxErGd8JeTiXqDOSIJAWUZ1s=;
        b=gPpiPRrkLj3Usb4qTvmG7u8B5SdzS/KZYpfZ3JVqJglbR5aBmCvbuiR3j2PFJvqTCK
         joB5nJAhASyxRzGJGyvhjo9/sycI85bJU8Z5p5mWw1GFgVQmuSplsgtK/nrOX6JG4eE/
         nt7nqLBGdpsT5wUY9F+VkpJ8gzK7zToqXyQ/fbzpLl0AtmlEQf38Q4acBzX5f8xb0K08
         TW3uGklEyBqfGpIxHk/L3DR/CrNHTVVKfTy2IbMd0Ql927BSFuWQhZ6qKf2lZhblg2LA
         sNa6+eb9Bsbn3uSs9a50VeoM8OSTryynjx9JWl8GAmP1ba62DVBNVqLeA5f9Hqi0Nr0J
         ZSwg==
X-Forwarded-Encrypted: i=1; AJvYcCUvuF0onMg2hfLa+MzmE0OX5s6T5fUMfhpLuI7Uoqu0ihYKXnfzAR7p2yoAfE7owW2XqAsIJ5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM0s1HsKq9XM/01kNJt3N/BuBFeK71kWCyT+kt4ZoASFzpfUYx
	TmyMYE0euVBAxZfvk6yQfU0h8nXHi5MA/TcQvu5hqCcwWOb1czDPpUBQrG46JrjN6ELw/ukLER2
	km4XaRbQpab4CoIhuxuIv/YEmdJaJqQI=
X-Gm-Gg: ATEYQzx+ZQrnWGSPB6prKo59Er6M6X3QtjOKJP3G1fYbb6Rl5YWtNvmQsU6xeuTMjmg
	25aCZNo8jA9SA0cqeE5QnD2Vdv3ojH2Mh30LLBUiDdsnHykUzBWQueykMeNceoc4laP+si44CNA
	laJ3e11B6sc4mb+ebV1LB+XoUry804FcIVE/leP6kqXVlFvj0CjnNlnz1OoxiRhKyQay/psfcCX
	jwofdb590Ny+/qw4eJqZgV91axAc+nLe2H9Kj5xOQHY2z/6VsBY1wR+SwSjFRgUh2pOpM/aEehn
	qd0TFzQ=
X-Received: by 2002:a05:6102:cd1:b0:600:20:74f8 with SMTP id
 ada2fe7eead31-6027d12e74cmr2244655137.13.1773850912407; Wed, 18 Mar 2026
 09:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303140725.86260-1-seanwascoding@gmail.com>
 <de652c45-9492-4bb8-a173-efce703b5174@app.fastmail.com> <CAAb=EJViPvhD_ndONoU=OPcD_EXpA0Mh8500NJ9g9W_X0SpYRA@mail.gmail.com>
 <63721454-ffbe-4725-b2c3-843560a3d5e0@app.fastmail.com> <CAAb=EJVw8S9o+N2JcBQridSPeNOHQgpiFAPqeNV-X-uSxwjvqg@mail.gmail.com>
 <abljNCs_wjNELf6b@ashevche-desk.local>
In-Reply-To: <abljNCs_wjNELf6b@ashevche-desk.local>
From: Sean Chang <seanwascoding@gmail.com>
Date: Thu, 19 Mar 2026 00:21:41 +0800
X-Gm-Features: AaiRm52RxoZ9zoDXEHEReqGGGsP114OiKOh1K2PEy0S4Gpi8Filgw6YhnVYGX-c
Message-ID: <CAAb=EJXA+SVPWLcWu1WRr-8A5Vk0k4za09+ROFqYX2eceH65XA@mail.gmail.com>
Subject: Re: [PATCH v2] sunrpc: simplify dprintk() macros and cleanup
 redundant debug guards
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Chuck Lever <cel@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, Anna Schumaker <anna@kernel.org>, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269109-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,oracle.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.829];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DD502C033A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 10:20=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> > > > > Does this patch fixes also 202603110038.P6d14oxa-lkp@intel.com?
> > > >
> > > > Regarding the LKP report:
> > > > I have reproduced the Sparse warning (void vs int mismatch) locally=
.
> > > > To resolve this, I'll use the do-while(0) form in v3 to ensure the =
macro
> > > > always evaluates to void:
> > > > -# define dfprintk(fac, ...)            no_printk(__VA_ARGS__)
> > > > -# define dfprintk_rcu(fac, ...)        no_printk(__VA_ARGS__)
> > > > +# define dfprintk(fac, ...)            do { no_printk(__VA_ARGS__)=
; } while (0)
> > > > +# define dfprintk_rcu(fac, ...)        do { no_printk(__VA_ARGS__)=
; } while (0)
> > >
> > > Wouldn't be better to drop ({}) in nfs_error*() macros?
> >
> > I understand that the ({}) wrapper might look redundant at first
> > glance. However,
> > even if I remove it, the return type remains an issue because no_printk=
() (which
> > dprintk() expands to) already contains its own ({}) statement expressio=
n.
> >
> > To resolve this without refactoring errorf(), which hasn't been
> > touched in years,
> > I believe modifying dfprintk() is the better path.
> >
> > One alternative is to explicitly force the return type to void like thi=
s:
> > ({ dprintk(fmt "\n", ##__VA_ARGS__); (void)0; })
> >
> > While this ensures the return type remains void (consistent with the
> > behavior before
> > dprintk() was redefined), it is admittedly clunky. We could wrap
> > (void)0 in a macro like
> > #define nothing_to_do ((void)0), but that adds unnecessary complexity.
> >
> > Therefore, I still prefer Option 1, as it restores the original
> > behavior from before the
> > recent commits and maintains the cleanest code structure for this subsy=
stem.
> > What do you think?
>
> Personally I found the ({}) in nfs_error*() redundant and the point of th=
ose
> functions not being touched in years doesn't work for internal APIs. Do y=
ou
> know the reason why it wasn't touched? Perhaps there was nothing to do si=
mply
> with that until dprintk() issue reveals some (legacy?) stuff to improve.
>
> I would not go with (void)0 approach, but I also think that dropping unne=
eded
> (if confirmed) expression wrapping is a good thing to do.
>

Hi Andy,
Thanks for your comment, how about removing the ({}) and ternary operator t=
o
prevent sparse throw incompatible types. And use the do{} while(0) to preve=
nt
dangling-else problem.

#define nfs_errorf(fc, fmt, ...) do { \
    if ((fc)->log.log) \
        errorf(fc, fmt, ## __VA_ARGS__); \
    else \
        dprintk(fmt "\n", ## __VA_ARGS__); \
} while (0)

