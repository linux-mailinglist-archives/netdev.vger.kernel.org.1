Return-Path: <netdev+bounces-56305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F31A980E77D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA071C2164E
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB79584DD;
	Tue, 12 Dec 2023 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hyh58MHr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F35FF5
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 01:23:42 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7c5060a9e5bso1706965241.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 01:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702373021; x=1702977821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUd+xJBalOQAWlVtKqp2TzvFJgkF52NQ9jKhRyu6zf0=;
        b=Hyh58MHrRypDZ9Pb/9prTpxrvpIRvjnuFT2hIR2rVwMIkWg/qP3B7w7pMyuuUS/3+N
         9rsq7fOJH0P/lS3Ntd8D7UAmXbgxJnVZogXzONwrtkEd1lt+MDLM5pmNaFRJMBHlN/e2
         YuYa6MPPKzWl44Zp/Mp7zfZb4cmegyFwVKZFdY2tKjDua+sSUnD9Lz2Mpgn5V3ioCxRD
         CG2DuiQ71ueuevfCKg8IwXGQ5Aq93B7BL8YNVnnVMuGVTHSps08Moe4ddeuveWMC60Bt
         OWI+TeZ20U9Gaf3MLzM6DiiinGefbGiMu8B2XX26SD68DurKd8TBt/5vjIv8Ujje0dCl
         dJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702373021; x=1702977821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUd+xJBalOQAWlVtKqp2TzvFJgkF52NQ9jKhRyu6zf0=;
        b=O/vrLCw0DJVTJ55GhvnUHhfyPPqXkStlgFmU9eNOyZNXk/vhu5pWtpCBPSsr/gX0rY
         FCWlM/cbHGilUvAiTtcnNsHYSUQKPibS/u+gBljNI9QLZK8oT9Py3x5xnbFhZzULWrsB
         C4QR7eVspD1e243Dc6xKXaT8/dLFFmKjYisXUqFGQkQ74kGfJaMF+0giFoGa4dMRo6R7
         sWA97Y5C9YDxF8gcP61nCQo7jIw01j5lbWtMbK/zfG+nEWTFfVoNSR7sD+JcrxsBBbog
         m8aTAvLSn4g0VJadHZSSO40wpcG+KEJIqHngloMOTkZykrvNCNxp4ql6KgnzBbWSIuox
         /rxQ==
X-Gm-Message-State: AOJu0Yx5Zod8+uHT5j33ssUZSNfFRwP07nlP83NtVVv+iFrm40DdukFb
	SOlDI95MuSc/9naMsWXs1jpXz2p9Fncd8XAYUsqe7w==
X-Google-Smtp-Source: AGHT+IFgUCvvmzmX278q9Co+7QDNrP8fTgs5dO167XgwKzPZkRE3j0AtMw1ja2f/aExIsIQLu3r25rvviPcmOCdi/SU=
X-Received: by 2002:a05:6102:4413:b0:464:8960:4827 with SMTP id
 df19-20020a056102441300b0046489604827mr3363440vsb.7.1702373020886; Tue, 12
 Dec 2023 01:23:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231210234924.1453917-1-fujita.tomonori@gmail.com>
 <20231210234924.1453917-2-fujita.tomonori@gmail.com> <ccf2b9af-1c8c-44c4-bb93-51dd9ea1cccf@ryhl.io>
 <20231212.081505.1423250811446494582.fujita.tomonori@gmail.com>
In-Reply-To: <20231212.081505.1423250811446494582.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 12 Dec 2023 10:23:30 +0100
Message-ID: <CAH5fLghyo3vdrQvQgRsMHp6Hh1=L5+PqHbfBXoF7t4E4URN_vw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: alice@ryhl.io, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, 
	benno.lossin@proton.me, wedsonaf@gmail.com, boqun.feng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 12:15=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Mon, 11 Dec 2023 22:46:01 +0100
> Alice Ryhl <alice@ryhl.io> wrote:
> >> +    /// Gets the state of PHY state machine states.
> >> +    pub fn state(&self) -> DeviceState {
> >> +        let phydev =3D self.0.get();
> >> +        // SAFETY: The struct invariant ensures that we may access
> >> +        // this field without additional synchronization.
> >> +        let state =3D unsafe { (*phydev).state };
> >> + // TODO: this conversion code will be replaced with automatically
> >> generated code by bindgen
> >> +        // when it becomes possible.
> >> +        // better to call WARN_ONCE() when the state is out-of-range.
> >
> > Did you mix up two comments here? This doesn't parse in my brain.
>
> I'll remove the second comment because all we have to do here is using
> bindgen.
>
>
> >> +    /// Reads a given C22 PHY register.
> >> + // This function reads a hardware register and updates the stats so
> >> takes `&mut self`.
> >> +    pub fn read(&mut self, regnum: u16) -> Result<u16> {
> >> +        let phydev =3D self.0.get();
> >> + // SAFETY: `phydev` is pointing to a valid object by the type
> >> invariant of `Self`.
> >> +        // So an FFI call with a valid pointer.
> >
> > This sentence also doesn't parse in my brain. Perhaps "So it's just an
> > FFI call" or similar?
>
> "So it's just an FFI call" looks good. I'll fix all the places that
> use the same comment.

If you make those two comment changes, then you can add

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

